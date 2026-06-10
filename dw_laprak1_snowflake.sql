CREATE TABLE dim_produk (
    ID_Produk VARCHAR(10) PRIMARY KEY,
    ID_Katagori VARCHAR(10),
    ID_Satuan VARCHAR(10),
    Nama_Obat VARCHAR(50),
    Harga_Satuan DECIMAL(15,2),
    Stok_Total INT,
    FOREIGN KEY (ID_Katagori) REFERENCES dim_katagori(ID_Katagori),
    FOREIGN KEY (ID_Satuan) REFERENCES dim_satuan(ID_Satuan)
);

CREATE TABLE dim_lokasi (
    ID_Lokasi VARCHAR(10) PRIMARY KEY,
    Nama_Cabang VARCHAR(50),
    Alamat VARCHAR(100),
    Manager VARCHAR(50)
);

CREATE TABLE dim_waktu(
    ID_Waktu VARCHAR(10) PRIMARY KEY,
    Tanggal VARCHAR(20),
    Hari VARCHAR(10),
    Libur VARCHAR(10)
);

-- Dimensi Katagori
CREATE TABLE dim_katagori (
    ID_Katagori VARCHAR(10) PRIMARY KEY,
    Nama_Katagori VARCHAR(50)
);

-- Dimensi Satuan
CREATE TABLE dim_satuan (
    ID_Satuan VARCHAR(10) PRIMARY KEY,
    Jenis_Satuan VARCHAR(20)
);

CREATE TABLE fact_penjualan_obat (
    ID_Transaksi VARCHAR(10) PRIMARY KEY,
    ID_Produk VARCHAR(10),
    ID_Lokasi VARCHAR(10),
    ID_Waktu VARCHAR(10),
    Jumlah_Item INT,
    Total_Bayar DECIMAL(15,2),
    FOREIGN KEY (ID_Produk) REFERENCES dim_produk(ID_Produk),
    FOREIGN KEY (ID_Lokasi) REFERENCES dim_lokasi(ID_Lokasi),
    FOREIGN KEY (ID_Waktu) REFERENCES dim_waktu(ID_Waktu)
);

-- Isi Data Kategori
INSERT INTO dim_katagori (ID_Katagori, Nama_Katagori) VALUES 
('KA01', 'Obat Bebas'),
('KA02', 'Obat Keras'),
('KA03', 'Vitamin & Suplemen'),
('KA04', 'Alat Kesehatan'),
('KA05', 'Obat Herbal');

-- Isi Data Satuan
INSERT INTO dim_satuan (ID_Satuan, Jenis_Satuan) VALUES 
('SA01', 'Tablet'),
('SA02', 'Sirup/Botol'),
('SA03', 'Kapsul'),
('SA04', 'Sachet'),
('SA05', 'Pcs');

-- Isi Data Produk
INSERT INTO dim_produk (ID_Produk, ID_Katagori, ID_Satuan, Nama_Obat, Harga_Satuan, Stok_Total) VALUES
('PR01', 'KA01', 'SA01', 'Paracetamol 500mg', 5000.00, 200),
('PR02', 'KA03', 'SA01', 'Vitamin C 1000mg', 25000.00, 150),
('PR03', 'KA01', 'SA02', 'Obat Batuk Hitam', 15000.00, 80),
('PR04', 'KA02', 'SA03', 'Amoxicillin', 12000.00, 100),
('PR05', 'KA05', 'SA04', 'Tolak Angin', 4000.00, 300);

-- Isi Data Lokasi (Nama Manajer dan Cabang Lokal)
INSERT INTO dim_lokasi (ID_Lokasi, Nama_Cabang, Alamat, Manager) VALUES
('LO01', 'Apotek Duri Kosambi', 'Jl. Lingkar Luar Barat, Jakarta Barat', 'Bapak Dapon'),
('LO02', 'Apotek Kebon Jeruk', 'Jl. Raya Perjuangan, Jakarta Barat', 'Budi Santoso'),
('LO03', 'Apotek Dago', 'Jl. Ir. H. Juanda, Bandung', 'Siti Aminah'),
('LO04', 'Apotek Manyar', 'Jl. Manyar Kertoarjo, Surabaya', 'Andi Wijaya'),
('LO05', 'Apotek Malioboro', 'Jl. Malioboro, Yogyakarta', 'Rina Kartika');

-- Isi Data Waktu
INSERT INTO dim_waktu (ID_Waktu, Tanggal, Hari, Libur) VALUES
('WA01', '20-04-2026', 'Senin', 'Tidak'),
('WA02', '21-04-2026', 'Selasa', 'Tidak'),
('WA03', '22-04-2026', 'Rabu', 'Tidak'),
('WA04', '23-04-2026', 'Kamis', 'Tidak'),
('WA05', '24-04-2026', 'Jumat', 'Tidak');

-- Isi Data Fakta Penjualan
INSERT INTO fact_penjualan_obat (ID_Transaksi, ID_Produk, ID_Lokasi, ID_Waktu, Jumlah_Item, Total_Bayar) VALUES
('TR01', 'PR01', 'LO01', 'WA01', 2, 10000.00),
('TR02', 'PR02', 'LO02', 'WA02', 1, 25000.00),
('TR03', 'PR05', 'LO01', 'WA03', 10, 40000.00),
('TR04', 'PR03', 'LO03', 'WA04', 1, 15000.00),
('TR05', 'PR04', 'LO05', 'WA05', 3, 36000.00);

SELECT 
    k.Nama_Katagori, 
    AVG(f.Total_Bayar) AS Rata_Rata_Penjualan
FROM fact_penjualan_obat f
JOIN dim_produk p ON f.ID_Produk = p.ID_Produk
JOIN dim_katagori k ON p.ID_Katagori = k.ID_Katagori
GROUP BY k.Nama_Katagori;

SELECT 
    l.Nama_Cabang, 
    MIN(f.Total_Bayar) AS Penjualan_Terkecil, 
    MAX(f.Total_Bayar) AS Penjualan_Terbesar
FROM fact_penjualan_obat f
JOIN dim_lokasi l ON f.ID_Lokasi = l.ID_Lokasi
GROUP BY l.Nama_Cabang;