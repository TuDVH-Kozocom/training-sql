use thuctap;

-- 1. Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
select Magv, Hotengv, Tenkhoa
from tblgiangvien
inner join tblkhoa on tblgiangvien.Makhoa = tblkhoa.Makhoa;

-- 2. Đưa ra thông tin gồm mã số, họ tên và tên khoa của các giảng viên của khoa ‘DIA LY va QLTN’
select Magv, Hotengv, Tenkhoa
from tblgiangvien
inner join tblkhoa on tblgiangvien.Makhoa = tblkhoa.Makhoa
where Tenkhoa = 'Dia ly va QLTN';

-- 3.Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’
select count(*) as 'soluongsinhvien'
from tblsinhvien
inner join tblkhoa on tblsinhvien.Makhoa = tblkhoa.Makhoa
where Tenkhoa = 'CONG NGHE SINH HOC';

-- 4. Đưa ra danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa ‘TOAN’
select Masv, Hotensv, (year(now()) - Namsinh) as 'Tuoi'
from tblsinhvien
inner join tblkhoa on tblsinhvien.Makhoa = tblkhoa.Makhoa
where Tenkhoa = 'TOAN';

-- 5. Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’
select count(*) as 'soluonggianvien'
from tblgiangvien
inner join tblkhoa on tblgiangvien.Makhoa = tblkhoa.Makhoa
where Tenkhoa = 'CONG NGHE SINH HOC';

-- 6. Cho biết thông tin về sinh viên không tham gia thực tập
select *
from tblsinhvien
where Masv not in (select Masv
				from tblhuongdan);
                
-- 7.Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa
select tblkhoa.Makhoa, Tenkhoa, count(Magv) as 'Soluonggianvien'
from tblkhoa
inner join tblgiangvien on tblkhoa.Makhoa = tblgiangvien.Makhoa
group by tblkhoa.Makhoa;

-- 8. Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học
select Dienthoai
from tblkhoa
inner join tblsinhvien on tblkhoa.Makhoa = tblsinhvien.Makhoa
where Hotensv = 'Le van son';

-- 9. Cho biết mã số và tên của các đề tài do giảng viên ‘Tran son’ hướng dẫn
select Madt, Tendt
from tbldetai
where Madt in (select Madt
			from tblhuongdan
            inner join tblgiangvien on tblhuongdan.Magv = tblgiangvien.Magv
            where Hotengv = 'Tran son');
            
-- 10. Cho biết tên đề tài không có sinh viên nào thực tập
select Tendt
from tbldetai
where Madt not in (select distinct Madt
			from tblhuongdan
            inner join tblsinhvien on tblhuongdan.Masv = tblsinhvien.Masv);
            
-- 11. Cho biết mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sinh viên trở lên.
select Magv, Hotengv, Tenkhoa
from tblgiangvien
inner join tblkhoa on tblgiangvien.Makhoa = tblkhoa.Makhoa
where Magv in (select Magv
			from tblhuongdan
			inner join tblsinhvien on tblhuongdan.Masv = tblsinhvien.Masv
			group by Magv
			having count(tblhuongdan.Masv) >= 3);
            
-- 12. Cho biết mã số, tên đề tài của đề tài có kinh phí cao nhất
select Madt, Tendt
from tbldetai
where Kinhphi = (select max(Kinhphi)
				from tbldetai);

-- 14. Đưa ra mã số, họ tên và điểm của các sinh viên khoa ‘DIALY và QLTN’
select tblsinhvien.Masv, Hotensv, Ketqua
from tblhuongdan
inner join tblsinhvien on tblhuongdan.Masv = tblsinhvien.Masv
where Makhoa = (select Makhoa
			from tblkhoa
			where Tenkhoa = 'Dia ly va QLTN');
            
-- 15. Đưa ra tên khoa, số lượng sinh viên của mỗi khoa
select Tenkhoa, count(Masv) as 'Soluongsinhvien'
from tblkhoa
inner join tblsinhvien on tblkhoa.Makhoa = tblsinhvien.Makhoa
group by tblkhoa.Makhoa;

-- 16. Cho biết thông tin về các sinh viên thực tập tại quê nhà
select tblsinhvien.*
from tblsinhvien
inner join tblhuongdan on tblsinhvien.Masv = tblhuongdan.Masv
inner join tbldetai on tblhuongdan.Madt = tbldetai.Madt
where Quequan = Noithuctap;

-- 17. Hãy cho biết thông tin về những sinh viên chưa có điểm thực tập
select tblsinhvien.*
from tblsinhvien
inner join tblhuongdan on tblsinhvien.Masv = tblhuongdan.Masv
where Ketqua is null;

-- 18. Đưa ra danh sách gồm mã số, họ tên các sinh viên có điểm thực tập bằng.
select tblsinhvien.*
from tblsinhvien
inner join tblhuongdan on tblsinhvien.Masv = tblhuongdan.Masv
where Ketqua = 8;