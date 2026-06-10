INSERT INTO account (id_account, no_hp_asli, username_wa, privacy_setting) VALUES
('ACC001', '6281234567890', 'Ahmad Sanusi', 'Contacts Only'),
('ACC002', '6281111111111', 'Budi Santoso', 'Public'),
('ACC003', '6282222222222', 'Siti Aminah', 'Contacts Only'),
('ACC004', '6283333333333', 'Agus Mulyono', 'Nobody'),
('ACC005', '6284444444444', 'Dewi Lestari', 'Public'),
('ACC006', '6285555555555', 'Eko Prasetyo', 'Contacts Only'),
('ACC007', '6286666666666', 'Rina Wijaya', 'Public'),
('ACC008', '6287777777777', 'Teddy wirawan', 'Contacts Only'),
('ACC009', '6288888888888', 'Mega Utami', 'Public'),
('ACC010', '6289999999999', 'Bihlal Lihadia', 'Nobody');

INSERT INTO contact (id_contact, id_account, nomor_tersimpan, nama_kontak_custom) VALUES
('CON001', 'ACC002', '6281111111111', 'Budi Cs'),
('CON002', 'ACC004', '6283333333333', 'Pak Agus Galon'),
('CON003', 'ACC001', '6281234567890', 'Ahmad Bengkel'),
('CON004', 'ACC005', '6284444444444', 'Dewi Arisan'),
('CON005', 'ACC003', '6282222222222', 'Ibu Siti Rt'),
('CON006', 'ACC008', '6287777777777', 'Teddy Sekretaris'),
('CON007', 'ACC006', '6285555555555', 'Eko Teman SMA'),
('CON008', 'ACC007', '6286666666666', 'Rina Sepupu'),
('CON009', 'ACC010', '6289999999999', 'Bihlal Minyak'),
('CON010', 'ACC009', '6288888888888', 'Mbak Mega');

INSERT INTO chat (id_chat, kode_room, tipe_chat) VALUES
('CHT001', 'ROOM-PC-01', 'Personal'),
('CHT002', 'ROOM-PC-02', 'Personal'),
('CHT003', 'ROOM-PC-03', 'Personal'),
('CHT004', 'ROOM-PC-04', 'Personal'),
('CHT005', 'ROOM-PC-05', 'Personal'),
('CHT006', 'ROOM-GR-01', 'Group'),
('CHT007', 'ROOM-GR-02', 'Group'),
('CHT008', 'ROOM-GR-03', 'Group'),
('CHT009', 'ROOM-GR-04', 'Group'),
('CHT010', 'ROOM-GR-05', 'Group'),
('CHT011', 'ROOM-PC-06', 'Personal'),
('CHT012', 'ROOM-PC-07', 'Personal'),
('CHT013', 'ROOM-PC-08', 'Personal'),
('CHT014', 'ROOM-GR-06', 'Group'),
('CHT015', 'ROOM-GR-07', 'Group'),
('CHT016', 'ROOM-GR-08', 'Group'),
('CHT017', 'ROOM-GR-09', 'Group'),
('CHT018', 'ROOM-GR-10', 'Group'),
('CHT019', 'ROOM-GR-11', 'Group'),
('CHT020', 'ROOM-GR-12', 'Group');

INSERT INTO group_chat (id_group, id_chat, nama_grup, id_account_creator, total_anggota) VALUES
('GRP001', 'CHT006', 'Anak TI ITPLN 2026', 'ACC004', 80),
('GRP002', 'CHT007', 'Keluarga Besar', 'ACC002', 15),
('GRP003', 'CHT008', 'Info Kos-Kosan', 'ACC003', 45),
('GRP004', 'CHT009', 'Alumni SMA 1', 'ACC005', 120),
('GRP005', 'CHT010', 'Proyek Bot WhatsApp', 'ACC001', 5),
('GRP006', 'CHT014', 'Mabar MLBB MCGG', 'ACC001', 10),
('GRP007', 'CHT015', 'Panitia Expo Basis Data', 'ACC004', 25),
('GRP008', 'CHT016', 'Beans Base Developer', 'ACC001', 4),
('GRP009', 'CHT017', 'Fans Barcelona Indo', 'ACC006', 250),
('GRP010', 'CHT018', 'Grup Kuliah Cloud', 'ACC008', 35);

INSERT INTO isi_chat (id_waktu, id_chat, id_account_sender, total_pesan_terkirim, total_bytes_media) VALUES
('20260608', 'CHT001', 'ACC001', 15, 45000),
('20260608', 'CHT006', 'ACC004', 8, 0),
('20260608', 'CHT017', 'ACC001', 120, 4800000),
('20260609', 'CHT001', 'ACC001', 30, 120000),
('20260609', 'CHT006', 'ACC002', 45, 950000),
('20260609', 'CHT008', 'ACC003', 12, 0),
('20260609', 'CHT010', 'ACC001', 65, 15000),
('20260610', 'CHT001', 'ACC002', 22, 0),
('20260610', 'CHT006', 'ACC001', 55, 1250000),
('20260610', 'CHT007', 'ACC002', 5, 3500000),
('20260610', 'CHT017', 'ACC006', 14, 0),
('20260610', 'CHT018', 'ACC001', 80, 450000);

INSERT INTO calls (id_waktu, id_account, total_panggilan_masuk, total_panggilan_keluar, total_durasi_detik) VALUES
('20260608', 'ACC001', 1, 3, 450),
('20260608', 'ACC006', 8, 5, 5400),
('20260609', 'ACC001', 4, 2, 1800),
('20260609', 'ACC003', 2, 2, 600),
('20260609', 'ACC004', 1, 0, 150),
('20260609', 'ACC005', 0, 4, 1100),
('20260610', 'ACC001', 2, 5, 2400),
('20260610', 'ACC002', 5, 1, 900),
('20260610', 'ACC007', 3, 3, 1350),
('20260610', 'ACC008', 0, 2, 300);

INSERT INTO status (id_waktu, id_account, total_status_dibuat, total_viewers) VALUES
('20260608', 'ACC001', 4, 65),
('20260608', 'ACC009', 2, 150),
('20260609', 'ACC001', 1, 78),
('20260609', 'ACC003', 2, 40),
('20260609', 'ACC007', 3, 210),
('20260610', 'ACC001', 2, 95),
('20260610', 'ACC002', 1, 134),
('20260610', 'ACC004', 1, 12),
('20260610', 'ACC005', 4, 88),
('20260610', 'ACC006', 2, 105);