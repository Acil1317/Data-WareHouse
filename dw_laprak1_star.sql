-- 1. Dimensi Produk
CREATE TABLE dim_produk (
    ID_Produk VARCHAR(10) PRIMARY KEY,
    Nama_Obat VARCHAR(50),
    Kategori VARCHAR(50),
    Harga_Satuan DECIMAL(15,2)
);

-- 2. Dimensi Supplier
CREATE TABLE dim_supplier (
    ID_Supplier VARCHAR(10) PRIMARY KEY,
    Nama_Vendor VARCHAR(50),
    Alamat_Supplier VARCHAR(100),
    No_Telp VARCHAR(13)
);

-- 3. Dimensi Lokasi
CREATE TABLE dim_lokasi (
    ID_Lokasi VARCHAR(10) PRIMARY KEY,
    Nama_Cabang VARCHAR(50),
    Kota VARCHAR(50),
    Wilayah VARCHAR(50)
);

-- 4. Dimensi Waktu
CREATE TABLE dim_waktu (
    ID_Waktu VARCHAR(10) PRIMARY KEY,
    Tanggal VARCHAR(2),
    Bulan VARCHAR(2),
    Tahun VARCHAR(4)
);

-- fact table
CREATE TABLE fact_penjualan_obat (
    ID_Transaksi VARCHAR(10) PRIMARY KEY, -- Tambahan agar unik seperti di praktikum 2
    ID_Produk VARCHAR(10),
    ID_Supplier VARCHAR(10),
    ID_Lokasi VARCHAR(10),
    ID_Waktu VARCHAR(10),
    Jumlah_Item INT,
    Total_Bayar DECIMAL(15,2),
    -- Relasi Foreign Key
    FOREIGN KEY (ID_Produk) REFERENCES dim_produk(ID_Produk),
    FOREIGN KEY (ID_Supplier) REFERENCES dim_supplier(ID_Supplier),
    FOREIGN KEY (ID_Lokasi) REFERENCES dim_lokasi(ID_Lokasi),
    FOREIGN KEY (ID_Waktu) REFERENCES dim_waktu(ID_Waktu)
);

-- Isi Dimensi Produk
INSERT INTO dim_produk VALUES
('PR01', 'Senzu Bean Tablet', 'Recovery', 50000.00),
('PR02', 'Luffy Meat Extract', 'Vitamin', 15000.00),
('PR03', 'Kyuubi Chakra Pills', 'Energy', 25000.00),
('PR04', 'Netsu-Go', 'Analgetik', 5000.00),
('PR05', 'Hollow Mask Syrup', 'Antibiotik', 30000.00);

-- Isi Dimensi Supplier
INSERT INTO dim_supplier VALUES
('SU01', 'Capsule Corp', 'West City', '081234567890'),
('SU02', 'Gotei 13 Medical', 'Soul Society', '081299988877'),
('SU03', 'Konoha Pharmacy', 'Hidden Leaf Village', '081377766655'),
('SU04', 'Speedwagon Foundation', 'London', '081122233344'),
('SU05', 'Future Gadget Lab', 'Akihabara', '081900011122');

-- Isi Dimensi Lokasi
INSERT INTO dim_lokasi VALUES
('LO01', 'Cabang Konoha', 'Tokyo', 'Timur'),
('LO02', 'Cabang Karakura', 'Saitama', 'Utara'),
('LO03', 'Cabang Namek', 'Bandung', 'Barat'),
('LO04', 'Cabang Dressrosa', 'Jakarta', 'Pusat'),
('LO05', 'Cabang Marley', 'Surabaya', 'Timur');

-- Isi Dimensi Waktu
INSERT INTO dim_waktu VALUES
('WT01', '01', '01', '2026'),
('WT02', '12', '02', '2026'),
('WT03', '25', '03', '2026'),
('WT04', '10', '04', '2026'),
('WT05', '20', '04', '2026');

-- Isi Tabel Fakta (Menghubungkan ID Varchar)
INSERT INTO fact_penjualan_obat VALUES
('TRX01', 'PR01', 'SU01', 'LO01', 'WT01', 2, 100000.00),
('TRX02', 'PR02', 'SU04', 'LO03', 'WT02', 10, 150000.00),
('TRX03', 'PR03', 'SU03', 'LO04', 'WT03', 4, 100000.00),
('TRX04', 'PR04', 'SU05', 'LO02', 'WT04', 5, 25000.00),
('TRX05', 'PR05', 'SU02', 'LO05', 'WT05', 1, 30000.00);

SELECT 
    p.Nama_Obat, 
    SUM(f.Jumlah_Item) AS Total_Obat_Terjual, 
    COUNT(f.ID_Transaksi) AS Frekuensi_Penjualan
FROM fact_penjualan_obat f
JOIN dim_produk p ON f.ID_Produk = p.ID_Produk
GROUP BY p.Nama_Obat;