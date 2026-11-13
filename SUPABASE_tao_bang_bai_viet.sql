-- ĐẠO VŨ: BẢNG BÀI VIẾT WEBSITE
-- Chạy toàn bộ đoạn SQL này trong Supabase > SQL Editor.
-- Khách truy cập chỉ được đọc; chỉ email quản trị được đăng/xóa bài.

create table if not exists public.website_articles (
  id text primary key,
  course text not null check (course in ('karate','football','swimming','finger','balance')),
  title text not null,
  html text not null default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

alter table public.website_articles enable row level security;

drop policy if exists "Public can read website articles" on public.website_articles;
create policy "Public can read website articles"
on public.website_articles for select to anon, authenticated using (true);

drop policy if exists "Admin can insert website articles" on public.website_articles;
create policy "Admin can insert website articles"
on public.website_articles for insert to authenticated
with check ((auth.jwt() ->> 'email') = 'xuanphuong.wekiss@gmail.com');

drop policy if exists "Admin can update website articles" on public.website_articles;
create policy "Admin can update website articles"
on public.website_articles for update to authenticated
using ((auth.jwt() ->> 'email') = 'xuanphuong.wekiss@gmail.com')
with check ((auth.jwt() ->> 'email') = 'xuanphuong.wekiss@gmail.com');

drop policy if exists "Admin can delete website articles" on public.website_articles;
create policy "Admin can delete website articles"
on public.website_articles for delete to authenticated
using ((auth.jwt() ->> 'email') = 'xuanphuong.wekiss@gmail.com');

grant select on public.website_articles to anon, authenticated;
grant insert, update, delete on public.website_articles to authenticated;

-- Nạp sẵn 5 bài giới thiệu gốc để khách truy cập vẫn thấy nội dung ngay sau khi tạo bảng.
insert into public.website_articles (id, course, title, html, sort_order)
values
('intro-karate', 'karate', 'Giới thiệu môn học', '<p>Karate không chỉ là môn võ thuật rèn luyện sức khỏe, mà còn là hành trình giáo dục nhân cách, ý chí và tinh thần kỷ luật cho trẻ em.</p><p>Tại Trung tâm Đạo Vũ, mỗi buổi tập là cơ hội để các em học cách tôn trọng thầy cô, đoàn kết với bạn bè, vượt qua giới hạn của bản thân và trưởng thành qua từng động tác.</p><p>Thông qua luyện tập Kihon, Kata, Kumite và các bài tập thể lực phù hợp, các em từng bước phát triển sức mạnh, sự nhanh nhẹn, khả năng tập trung và bản lĩnh.</p><p>Đạo Vũ tin rằng một võ sinh giỏi không chỉ được đánh giá bằng đai đẳng hay kỹ thuật, mà còn bằng lễ phép, lòng nhân ái, tinh thần trách nhiệm và cách ứng xử trong cuộc sống.</p><p><strong>Karate Đạo Vũ – Rèn thân thể khỏe mạnh, nuôi dưỡng tâm hồn đẹp, xây dựng thế hệ trẻ bản lĩnh và nhân cách.</strong></p>', 0),
('intro-football', 'football', 'Giới thiệu môn học', '<p>Bóng đá là môn thể thao của niềm vui, sự đoàn kết và khát vọng chinh phục. Trên sân cỏ, mỗi đứa trẻ không chỉ được vận động mà còn học cách phối hợp, sẻ chia và cùng nhau hướng đến mục tiêu chung.</p><p>Tại Trung tâm Đạo Vũ, chương trình Bóng đá tạo điều kiện để các em phát triển thể chất, rèn luyện sự nhanh nhẹn, sức bền, khả năng quan sát và phản xạ.</p><p>Qua từng đường chuyền, cú sút và trận đấu, các em học được tinh thần đồng đội, sự tự tin, tính kỷ luật và thái độ fair-play. Các em hiểu rằng chiến thắng đáng quý, nhưng sự cố gắng, tinh thần đoàn kết và thái độ đẹp còn đáng quý hơn.</p><p>Đạo Vũ mong muốn mỗi buổi tập là một sân chơi bổ ích, nơi trẻ được thỏa sức vận động, nuôi dưỡng đam mê và lưu giữ những kỷ niệm tuổi thơ tươi đẹp.</p><p><strong>Bóng đá Đạo Vũ – Khỏe thể chất, vững tinh thần, kết nối tình bạn và nuôi dưỡng ước mơ.</strong></p>', 100),
('intro-swimming', 'swimming', 'Giới thiệu môn học', '<p>Bơi lội không chỉ là một môn thể thao giúp phát triển thể chất, mà còn là kỹ năng sống quan trọng đối với mỗi trẻ em.</p><p>Tại Trung tâm Đạo Vũ, chương trình Bơi lội hướng đến việc giúp các em làm quen với môi trường nước, từng bước học kỹ thuật bơi phù hợp, rèn luyện sự tự tin và nâng cao ý thức an toàn dưới nước.</p><p>Thông qua quá trình luyện tập, trẻ có cơ hội phát triển sức bền, khả năng phối hợp vận động, sự linh hoạt và tính kiên trì. Mỗi kỹ năng mới được chinh phục là một bước tiến giúp các em thêm mạnh dạn và chủ động.</p><p>Đạo Vũ luôn đề cao tinh thần học tập nghiêm túc, rèn luyện đúng kỹ thuật và ý thức tuân thủ các nguyên tắc an toàn. Bởi biết bơi cần đi đôi với biết bảo vệ bản thân và tôn trọng môi trường nước.</p><p><strong>Bơi lội Đạo Vũ – Rèn luyện sức khỏe, trang bị kỹ năng sống, chắp cánh sự tự tin cho trẻ.</strong></p>', 200),
('intro-finger', 'finger', 'Giới thiệu môn học', '<p>Mỗi đứa trẻ đều có khả năng tư duy và khám phá thế giới số học theo cách riêng. Điều quan trọng là tạo ra phương pháp học tập phù hợp để trẻ cảm thấy hứng thú và tự tin.</p><p>Tại Trung tâm Đạo Vũ, chương trình Toán Finger Math hướng đến việc giúp trẻ làm quen với các con số và phép tính thông qua phương pháp sử dụng ngón tay kết hợp tư duy trực quan.</p><p>Qua từng hoạt động học tập, trẻ có cơ hội rèn luyện khả năng quan sát, ghi nhớ, tập trung và phản xạ tính toán. Việc học được tổ chức theo hướng gần gũi, sinh động, giúp trẻ từng bước hình thành sự tự tin khi tiếp cận toán học.</p><p>Đạo Vũ không chỉ mong muốn trẻ thực hiện phép tính nhanh hơn, mà còn mong các em yêu thích việc học, mạnh dạn khám phá và phát triển tư duy một cách tự nhiên.</p><p><strong>Toán Finger Math Đạo Vũ – Học bằng trải nghiệm, phát triển tư duy, tự tin khám phá thế giới số.</strong></p>', 300),
('intro-balance', 'balance', 'Giới thiệu môn học', '<p>Tuổi thơ là hành trình của những lần khám phá và chinh phục những điều mới mẻ. Với xe thăng bằng, mỗi vòng bánh xe lăn là một cơ hội để trẻ trải nghiệm, vận động và trưởng thành.</p><p>Tại Trung tâm Đạo Vũ, chương trình Xe thăng bằng tạo môi trường để trẻ rèn luyện khả năng giữ thăng bằng, phối hợp tay – mắt, điều khiển cơ thể và phản xạ vận động.</p><p>Qua những hoạt động phù hợp với lứa tuổi, trẻ học cách quan sát, chủ động điều khiển xe, làm quen với việc giữ thăng bằng và tự tin vượt qua những thử thách nhỏ.</p><p>Điều Đạo Vũ trân trọng không chỉ là việc trẻ có thể điều khiển chiếc xe tốt hơn, mà còn là nụ cười, sự mạnh dạn và niềm vui khi các em tự mình chinh phục một kỹ năng mới.</p><p>Các hoạt động cần được tổ chức trong khu vực phù hợp, có hướng dẫn và trang bị bảo hộ cần thiết.</p><p><strong>Xe thăng bằng Đạo Vũ – Vững vàng vận động, tự tin khám phá, vui khỏe mỗi ngày.</strong></p>', 400)
on conflict (id) do nothing;
