-- Roll Up
SELECT 
    c.tipe_chat,
    SUM(i.total_pesan_terkirim) AS grand_total_pesan,
    SUM(i.total_bytes_media) AS grand_total_kuota_media_bytes
FROM isi_chat i
JOIN chat c ON i.id_chat = c.id_chat
GROUP BY c.tipe_chat;

-- Drill Down
SELECT 
    c.tipe_chat,
    g.nama_grup,
    SUM(i.total_pesan_terkirim) AS total_pesan_grup
FROM isi_chat i
JOIN chat c ON i.id_chat = c.id_chat
JOIN group_chat g ON c.id_chat = g.id_chat -- Fitur bercabang Snowflake
GROUP BY c.tipe_chat, g.nama_grup;

-- Slice
SELECT 
    i.id_waktu AS tanggal,
    a.username_wa,
    SUM(i.total_pesan_terkirim) AS total_pesan_masuk_hari_ini
FROM isi_chat i
JOIN account a ON i.id_account_sender = a.id_account
WHERE a.id_account = 'ACC001' -- Proses Slice pada Akun Yin
GROUP BY i.id_waktu, a.username_wa;

-- Dice
SELECT 
    i.id_waktu AS tanggal,
    c.tipe_chat,
    g.nama_grup,
    SUM(i.total_pesan_terkirim) AS total_pesan
FROM isi_chat i
JOIN chat c ON i.id_chat = c.id_chat
JOIN group_chat g ON c.id_chat = g.id_chat
WHERE i.id_waktu = '20260610' AND c.tipe_chat = 'Group' -- Proses Dice (Dua Filter)
GROUP BY i.id_waktu, c.tipe_chat, g.nama_grup;

-- Pivot
SELECT 
    id_account_sender,
    SUM(CASE WHEN id_waktu = '20260608' THEN total_pesan_terkirim ELSE 0 END) AS `Pesan_Tgl_08`,
    SUM(CASE WHEN id_waktu = '20260609' THEN total_pesan_terkirim ELSE 0 END) AS `Pesan_Tgl_09`,
    SUM(CASE WHEN id_waktu = '20260610' THEN total_pesan_terkirim ELSE 0 END) AS `Pesan_Tgl_10`
FROM isi_chat
GROUP BY id_account_sender;

-- Drill Across 
SELECT 
    a.username_wa,
    COALESCE(SUM(chat_data.total_pesan), 0) AS akumulasi_pesan_dikirim,
    COALESCE(SUM(call_data.total_durasi), 0) AS akumulasi_durasi_telpon_detik
FROM account a
-- Subquery Fakta 1: Chat
LEFT JOIN (
    SELECT id_account_sender, SUM(total_pesan_terkirim) AS total_pesan 
    FROM isi_chat GROUP BY id_account_sender
) chat_data ON a.id_account = chat_data.id_account_sender
-- Subquery Fakta 2: Panggilan
LEFT JOIN (
    SELECT id_account, SUM(total_durasi_detik) AS total_durasi 
    FROM calls GROUP BY id_account
) call_data ON a.id_account = call_data.id_account
GROUP BY a.username_wa;

-- Drill Through
-- Menampilkan baris data mentah asli dari tabel fakta untuk pengirim tertentu pada tanggal tertentu
SELECT 
    id_waktu AS tanggal,
    id_chat,
    id_account_sender,
    total_pesan_terkirim,
    total_bytes_media
FROM isi_chat
WHERE id_account_sender = 'ACC001' AND id_waktu = '20260610';