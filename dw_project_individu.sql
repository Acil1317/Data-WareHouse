-- Perbankan
CREATE TABLE dim_nasabah (
    nasabah_key INT,
    id_nasabah VARCHAR(10),
    nama_nasabah VARCHAR(100),
    kategori_resiko VARCHAR(50),
    wilayah_cabang VARCHAR(50),
    CONSTRAINT pk_nasabah PRIMARY KEY (nasabah_key)
);

CREATE TABLE dim_waktu (
    waktu_key INT,
    id_waktu
    tanggal DATE,
    bulan INT,
    kuartal INT,
    tahun INT,
    CONSTRAINT pk_waktu PRIMARY KEY (waktu_key)
);

CREATE TABLE dim_produk_kredit (
    produk_key INT,
    id_produk VARCHAR(10),
    jenis_pinjaman VARCHAR(50),
    suku_bunga DECIMAL(5,2),
    CONSTRAINT pk_produk PRIMARY KEY (produk_key)
);

CREATE TABLE fact_pinjaman (
    pinjaman_key INT,
    nasabah_key INT,
    waktu_key INT,
    produk_key INT,
    jumlah_plafon DECIMAL(15,2),
    sisa_outstanding DECIMAL(15,2),
    status_kolektibilitas INT,
    CONSTRAINT pk_pinjaman PRIMARY KEY (pinjaman_key),
    CONSTRAINT fk_pinjaman_nasabah FOREIGN KEY (nasabah_key) REFERENCES dim_nasabah(nasabah_key),
    CONSTRAINT fk_pinjaman_waktu FOREIGN KEY (waktu_key) REFERENCES dim_waktu(waktu_key),
    CONSTRAINT fk_pinjaman_produk FOREIGN KEY (produk_key) REFERENCES dim_produk_kredit(produk_key)
);
-- DQL
SELECT 
    dn.wilayah_cabang,
    dp.jenis_pinjaman,
    dw.tahun,
    dw.kuartal,
    SUM(fp.jumlah_plafon) AS total_plafon_kredit,
    SUM(fp.sisa_outstanding) AS total_sisa_pinjaman,
    AVG(fp.status_kolektibilitas) AS rata_rata_kolektibilitas
FROM fact_pinjaman fp
    JOIN dim_nasabah dn ON fp.nasabah_key = dn.nasabah_key
    JOIN dim_produk_kredit dp ON fp.produk_key = dp.produk_key
    JOIN dim_waktu dw ON fp.waktu_key = dw.waktu_key
GROUP BY dn.wilayah_cabang, dp.jenis_pinjaman, dw.tahun, dw.kuartal
GROUP BY total_size_pinjaman DESC;