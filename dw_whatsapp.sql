CREATE DATABASE dw_whatsapp;
USE dw_whatsapp;

CREATE TABLE account (
    id_account VARCHAR(10) PRIMARY KEY,
    no_hp_asli VARCHAR(20) NOT NULL,
    username_wa VARCHAR(100),
    privacy_setting VARCHAR(50)
);

CREATE TABLE contact (
    id_contact VARCHAR(10) PRIMARY KEY,
    id_account VARCHAR(10),
    nomor_tersimpan VARCHAR(20) NOT NULL,
    nama_kontak_custom VARCHAR(100),
    FOREIGN KEY (id_account) REFERENCES account(id_account) ON DELETE CASCADE
);

CREATE TABLE chat (
    id_chat VARCHAR(10) PRIMARY KEY,
    kode_room VARCHAR(50) NOT NULL,
    tipe_chat VARCHAR(20) NOT NULL
);

CREATE TABLE group_chat (
    id_group VARCHAR(10) PRIMARY KEY,
    id_chat VARCHAR(10),
    nama_grup VARCHAR(100) NOT NULL,
    id_account_creator VARCHAR(10),
    total_anggota INT DEFAULT 0,
    FOREIGN KEY (id_chat) REFERENCES chat(id_chat) ON DELETE CASCADE,
    FOREIGN KEY (id_account_creator) REFERENCES account(id_account) ON DELETE SET NULL
);

CREATE TABLE isi_chat (
    id_waktu VARCHAR(10) NOT NULL,
    id_chat VARCHAR(10),
    id_account_sender VARCHAR(10),
    total_pesan_terkirim INT DEFAULT 0,
    total_bytes_media BIGINT DEFAULT 0,
    PRIMARY KEY (id_waktu, id_chat, id_account_sender),
    FOREIGN KEY (id_chat) REFERENCES chat(id_chat) ON DELETE CASCADE,
    FOREIGN KEY (id_account_sender) REFERENCES account(id_account) ON DELETE CASCADE
);

CREATE TABLE calls (
    id_waktu VARCHAR(10) NOT NULL,
    id_account VARCHAR(10),
    total_panggilan_masuk INT DEFAULT 0,
    total_panggilan_keluar INT DEFAULT 0,
    total_durasi_detik INT DEFAULT 0,
    PRIMARY KEY (id_waktu, id_account),
    FOREIGN KEY (id_account) REFERENCES account(id_account) ON DELETE CASCADE
);

CREATE TABLE status (
    id_waktu VARCHAR(10) NOT NULL,
    id_account VARCHAR(10),
    total_status_dibuat INT DEFAULT 0,
    total_viewers INT DEFAULT 0,
    PRIMARY KEY (id_waktu, id_account),
    FOREIGN KEY (id_account) REFERENCES account(id_account) ON DELETE CASCADE
);

