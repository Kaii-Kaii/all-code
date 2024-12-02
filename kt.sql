-- Câu 1
GO
CREATE DATABASE D2_DB_BH
GO
USE D2_DB_BH

CREATE TABLE KHACH_HANG
(
MAKH INT PRIMARY KEY,
HOTEN NVARCHAR(100),
GIOITINH NVARCHAR(5),
DIACHI NVARCHAR(100)
)

INSERT INTO KHACH_HANG(MAKH, HOTEN, GIOITINH, DIACHI)
VALUES
	(01, N'Nguyễn Văn A', N'Nam', N'120 Lê Quang Định'),
	(02, N'Lê Thị B', N'Nữ', N'10 Nguyễn Văn Đậu')


-- Câu a
--- Thực hiện sao lưu dữ liệu (Full Backup) tại thời điểm t1: ---
BACKUP DATABASE D2_DB_BH 
TO DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_FULL.BAK' 
WITH INIT;

--Thêm dữ liệu
INSERT INTO KHACH_HANG(MAKH, HOTEN, GIOITINH, DIACHI)
VALUES
	(03, N'Nguyễn Văn C', N'Nam', N'04 Lê Trọng Tấn')


--- Thực hiện sao lưu dữ liệu (Log Backup) tại thời điểm t2: ---
BACKUP DATABASE D2_DB_BH 
TO DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_TRAN_1.TRN' 
WITH INIT;

--Thêm dữ liệu
INSERT INTO KHACH_HANG(MAKH, HOTEN, GIOITINH, DIACHI)
VALUES
	(04, N'Hồ mỹ D', N'Nữ', N'90 Tân Kỳ Tân Quý')

--- Thực hiện sao lưu khác biệt (Differential Backup) tại thời điểm t3: ---
BACKUP DATABASE D2_DB_BH 
TO DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_DIFF.BAK' 
WITH INIT;

--Thêm dữ liệu
INSERT INTO KHACH_HANG(MAKH, HOTEN, GIOITINH, DIACHI)
VALUES
	(05, N'Lưỡng Thị H', N'Nữ', N'180 Tân Kỳ Tân Quý')


--- Thực hiện sao lưu dữ liệu (Log Backup) tại thời điểm t4: ---
BACKUP DATABASE D2_DB_BH  
TO DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_TRAN_2.TRN' 
WITH INIT;


--Thêm dữ liệu
INSERT INTO KHACH_HANG(MAKH, HOTEN, GIOITINH, DIACHI)
VALUES
	(06, N'Nguyễn Tùng T', N'Nam', N'140 Lê Trọng Tấn')


--- Thực hiện sao lưu dữ liệu (Log Backup) tại thời điểm t5: ---
BACKUP DATABASE D2_DB_BH
TO DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_TRAN_3.TRN' 
WITH INIT;

--- Xóa dữ liệu để mô phỏng sự cố ---
DROP DATABASE D2_DB_BH


-- Câu b: Chạy hết lệnh khôi phục dưới 
RESTORE DATABASE D2_DB_BH
FROM DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_FULL.BAK' 
WITH NORECOVERY

RESTORE DATABASE D2_DB_BH
FROM DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_TRAN_1.TRN' 
WITH NORECOVERY

RESTORE DATABASE D2_DB_BH
FROM DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_DIFF.BAK' 
WITH NORECOVERY

RESTORE DATABASE D2_DB_BH
FROM DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_TRAN_2.TRN' 
WITH NORECOVERY

RESTORE DATABASE D2_DB_BH
FROM DISK = 'E:\LuuDuLieuSinhVien\03_2001221392_HoXuanTrungHiep\D2_DB_BH_TRAN_3.TRN' 
WITH RECOVERY


-- Xem lại dữ liệu
USE D2_DB_BH
SELECT * FROM KHACH_HANG

-- Câu 2

-- Không thể khôi phục 2 lần khi đã khôi phục 1 lần ở câu 1 với CSDL D2_DB_BH nên tạo mới CSDL D2_DB_BH_LAN và thêm dữ liệu vào giống CSDL D2_DB_BH
GO
CREATE DATABASE D2_DB_BH_LAN
GO
USE D2_DB_BH_LAN




CREATE TABLE KHACH_HANG
(
MAKH INT PRIMARY KEY,
HOTEN NVARCHAR(100),
GIOITINH NVARCHAR(5),
DIACHI NVARCHAR(100)
)

CREATE TABLE HANG(
MAHG INT PRIMARY KEY, 
TENHANG NVARCHAR(100)
)

INSERT INTO KHACH_HANG(MAKH, HOTEN, GIOITINH, DIACHI)
VALUES
	(01, N'Nguyễn Văn A', N'Nam', N'120 Lê Quang Định'),
	(02, N'Lê Thị B', N'Nữ', N'10 Nguyễn Văn Đậu'),
	(03, N'Nguyễn Văn C', N'Nam', N'04 Lê Trọng Tấn'),
	(04, N'Hồ mỹ D', N'Nữ', N'90 Tân Kỳ Tân Quý'),
	(05, N'Lưỡng Thị H', N'Nữ', N'180 Tân Kỳ Tân Quý'),
	(06, N'Nguyễn Tùng T', N'Nam', N'140 Lê Trọng Tấn'),

--a) 
-- Tạo tài khoản đăng nhập
CREATE LOGIN lgac1 WITH PASSWORD = '123';

-- Cấp quyền trên CSDL D2_DB_BH_LAN
USE D2_DB_BH_LAN;
CREATE USER lgac1 FOR LOGIN lgac1;
EXEC sp_addrolemember 'db_owner', 'lgac1';

-- Cấp quyền chỉ đọc trên CSDL D2_DB_BH
USE D2_DB_BH;
CREATE USER lgac1 FOR LOGIN lgac1;
EXEC sp_addrolemember 'db_datareader', 'lgac1';

--b/ Đăng nhập lgac1
USE D2_DB_BH_LAN
INSERT INTO HANG VALUES (01, 'HANG1');
INSERT INTO HANG VALUES (01, 'HANG2');

-- Vì CSDL D2_DB_BH_LAN có toàn quyền nên có thể thêm dữ liệu vào bảng HANG được

-- câu c/
-- Tạo tài khoản và người dùng
CREATE LOGIN usac2 WITH PASSWORD = '123';
CREATE LOGIN usac3 WITH PASSWORD = '123';

USE D2_DB_BH_LAN;
CREATE USER usac2 FOR LOGIN usac2;
CREATE USER usac3 FOR LOGIN usac3;

-- Cấp quyền thêm, xóa, sửa trên bảng LOPHOC
GRANT SELECT, INSERT, UPDATE ON HANG TO usac2;
GRANT SELECT, INSERT, UPDATE ON HANG TO usac3;

-- Đăng nhập usac3 để sửa dữ liệu
USE D2_DB_BH_LAN
UPDATE HANG
SET TENHANG = N'Quần áo'
WHERE MAHG = 01;

-- Sửa dữ liệu HANG được vì đã cấp quyền sửa trên tài khoản usac3

--Câu d/
USE D2_DB_BH_LAN
-- Tạo nhóm quyền NhomHH
EXEC sp_addrole 'NhomHH'
GRANT INSERT, SELECT ON HANG TO NhomHH;

-- Gán usac2 và usac3 vào nhóm NhomHH
EXEC sp_addrolemember 'NhomHH', 'usac2';
EXEC sp_addrolemember 'NhomHH', 'usac3';



-- Câu 3:
GO
CREATE DATABASE XE
GO
USE XE 

CREATE TABLE GHE(
SOGHE NVARCHAR(10),
MACHUYEN NVARCHAR(10),
GIAVE INT,
TRANGTHAI NVARCHAR(50),

PRIMARY KEY (SOGHE, MACHUYEN)
)

INSERT INTO GHE
VALUES
(N'A1',N'XE1',80,N'ĐÃ ĐẶT'),
(N'A2',N'XE1',80,N'ĐÃ ĐẶT'),
(N'A3',N'XE1',0,N'Trống')

--P1
BEGIN TRAN

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

UPDATE GHE
SET TRANGTHAI = N'ĐÃ ĐẶT'
WHERE SOGHE = N'A3'

WAITFOR DELAY '00:00:10';

ROLLBACK TRAN

--P2
BEGIN TRAN

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

SELECT  *
FROM GHE 
WHERE SOGHE = N'A3'  

COMMIT TRAN













