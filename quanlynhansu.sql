use quanlynhansu;

-- 1. Hiển thị thông tin của những nhân viên ở phòng số 5
select *
from nhanvien
where pgh = 5;

-- 2. Hiển thị mã nhân viên, họ nhân viên, tên lót và tên nhân viên của những nhân viên ở phòng số 5 và có lương >= 3000
select manv, honv, tenlot, tennv
from nhanvien
where pgh = 5 and luong >= 3000;

-- 3. Hiển thị mã nhân viên, tên nhân viên của những nhân viên có lương từ 2000 đến 8000
select manv, tennv
from nhanvien
where luong between 2000 and 8000;

-- 4. Hiển thị thông tin của những nhân viên ở địa chỉ có tên đường là Nguyễn
select *
from nhanvien
where diachi like 'Nguyễn%';

-- 5. Cho biết số lượng nhân viên
select count(*) as 'soluongnhanvien'
from nhanvien;

-- 6. Cho biết số lượng nhân viên trong từng phòng ban
select pgh, count(*) as 'soluongnhanvien'
from nhanvien
group by pgh;

-- 7. Hiển thị thông tin về mã nhân viên, tên nhân viên và tên phòng ban ở phòng kế toán
select manv, tennv, tenpgh
from nhanvien
inner join phongban on nhanvien.pgh = phongban.pgh
where tenpgh = 'Kế toán';

-- 8. Tìm thông tin của nhân viên làm từ 2 đề án trở lên.
select *
from nhanvien
where pgh in (select phongban.pgh
			from phongban
			inner join dean on phongban.pgh = dean.pgh
			group by phongban.pgh
			having count(dean.pgh) >= 2);