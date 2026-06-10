CREATE DATABASE db_olap_latihan;
USE db_olap_latihan;

CREATE TABLE fact_pendapatan (
    Tanggal DATE,
    Produk VARCHAR(50),
    Lokasi VARCHAR(50),
    Pendapatan INT
);

INSERT INTO fact_pendapatan (Tanggal, Produk, Lokasi, Pendapatan) VALUES
('2024-01-01', 'Produk A', 'Kota X', 1000),
('2024-01-01', 'Produk A', 'Kota Y', 1500),
('2024-01-01', 'Produk B', 'Kota X', 2000),
('2024-01-01', 'Produk B', 'Kota Y', 1200),
('2024-01-02', 'Produk A', 'Kota X', 1200),
('2024-01-02', 'Produk A', 'Kota Y', 1800),
('2024-01-02', 'Produk B', 'Kota X', 2100),
('2024-01-02', 'Produk B', 'Kota Y', 1300);

-- Roll Up
SELECT 
    Produk, 
    SUM(Pendapatan) AS Total_Pendapatan
FROM fact_pendapatan
GROUP BY Produk;

-- Drill Down
SELECT 
    Tanggal, 
    Produk, 
    Lokasi, 
    SUM(Pendapatan) AS Total_Pendapatan
FROM fact_pendapatan
GROUP BY Tanggal, Produk, Lokasi
ORDER BY Tanggal, Produk;

-- Slice
SELECT 
    Tanggal, 
    Produk, 
    Lokasi, 
    Pendapatan
FROM fact_pendapatan
WHERE Lokasi = 'Kota X';

-- Dice
SELECT 
    Tanggal, 
    Produk, 
    Lokasi, 
    Pendapatan
FROM fact_pendapatan
WHERE Produk = 'Produk A' AND Lokasi = 'Kota Y';

-- Pivot
SELECT 
    Tanggal,
    Produk,
    SUM(CASE WHEN Lokasi = 'Kota X' THEN Pendapatan ELSE 0 END) AS Pendapatan_Kota_X,
    SUM(CASE WHEN Lokasi = 'Kota Y' THEN Pendapatan ELSE 0 END) AS Pendapatan_Kota_Y
FROM fact_pendapatan
GROUP BY Tanggal, Produk;

-- Drill Across
SELECT 
    p.Tanggal,
    p.Produk, 
    p.Lokasi, 
    p.Pendapatan,
    s.Sisa_Stok
FROM fact_pendapatan p
JOIN fact_stok s 
  ON p.Tanggal = s.Tanggal 
  AND p.Produk = s.Produk 
  AND p.Lokasi = s.Lokasi;

-- Drill Through
SELECT 
    ID_Transaksi,       -- Menampilkan ID detail yang tidak ada di cube
    Waktu_Transaksi,    -- Jam spesifik (bukan sekadar tanggal)
    Nama_Pelanggan,     -- Detail operasional
    Produk, 
    Lokasi, 
    Nominal_Pembayaran AS Pendapatan
FROM transaksi_mentah
WHERE 
    Tanggal = '01/01/2024' 
    AND Produk = 'Produk A' 
    AND Lokasi = 'Kota X';

-- Pastikan tabelnya sudah dibuat terlebih dahulu
CREATE TABLE fact_stok (
    Tanggal DATE,
    Produk VARCHAR(50),
    Lokasi VARCHAR(50),
    Sisa_Stok INT
);

-- Proses input data yang selaras dengan dimensi di slide
INSERT INTO fakct_stok (Tanggal, Produk, Lokasi, Sisa_Stok) VALUES
('2024-01-01', 'Produk A', 'Kota X', 45),
('2024-01-01', 'Produk A', 'Kota Y', 12),
('2024-01-01', 'Produk B', 'Kota X', 80),
('2024-01-01', 'Produk B', 'Kota Y', 25),
('2024-02-01', 'Produk A', 'Kota X', 30),
('2024-02-01', 'Produk A', 'Kota Y', 8),
('2024-02-01', 'Produk B', 'Kota X', 95),
('2024-02-01', 'Produk B', 'Kota Y', 17);

-- Pastikan tabel data mentah (OLTP) sudah siap
CREATE TABLE transaksi_mentah (
    ID_Transaksi VARCHAR(10) PRIMARY KEY,
    Waktu_Transaksi DATETIME, -- Menggunakan DATETIME untuk presisi jam
    Tanggal DATE,
    Produk VARCHAR(50),
    Lokasi VARCHAR(50),
    Nama_Customer VARCHAR(50),
    Metode_Pembayaran VARCHAR(20),
    Nominal_Pembayaran INT
);

-- Mengisi data detail yang jika dijumlahkan (SUM) sesuai dengan baris di slide
INSERT INTO transaksi_mentah (ID_Transaksi, Waktu_Transaksi, Tanggal, Produk, Lokasi, Nama_Customer, Metode_Pembayaran, Nominal_Pembayaran) VALUES
-- Pemecahan untuk Produk A, Kota X, Tanggal 01/01/2024 (Total harus 1000)
('TX-001', '2024-01-01 09:15:22', '2024-01-01', 'Produk A', 'Kota X', 'Dewi', 'QRIS', 350),
('TX-002', '2024-01-01 13:42:10', '2024-01-01', 'Produk A', 'Kota X', 'Budi', 'Cash', 400),
('TX-003', '2024-01-01 19:05:55', '2024-01-01', 'Produk A', 'Kota X', 'Andi', 'Transfer Bank', 250),

-- Pemecahan untuk Produk A, Kota Y, Tanggal 01/01/2024 (Total harus 1500)
('TX-004', '2024-01-01 10:00:00', '2024-01-01', 'Produk A', 'Kota Y', 'Siti', 'QRIS', 800),
('TX-005', '2024-01-01 15:30:12', '2024-01-01', 'Produk A', 'Kota Y', 'Rian', 'Cash', 700);