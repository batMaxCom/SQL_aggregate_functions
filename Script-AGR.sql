--количество исполнителей в каждом жанре

select genre_id, count(*) from genre_performers
group by genre_id
order by genre_id asc; 

--количество треков, вошедших в альбомы 2019-2020 годов

select count(track_name) from track t
join album a on t.album_id=a.id
where release_album between '2019/01/01' and '2020/12/31';

--средняя продолжительность треков по каждому альбому

select avg(duration), album_name from track t 
join album a on t.album_id=a.id
group by album_name;

--все исполнители, которые не выпустили альбомы в 2020 году

select nickname from list_of_performers 
where nickname not in (
	select nickname from list_of_performers
	join album_performers ap on ap.nickname_id = list_of_performers .id
	join album a on ap.album_id = a.id
	where release_album between '2020/01/01' and '2020/12/31');

--названия сборников, в которых присутствует конкретный исполнитель

select distinct collection_name from music_collection mc 
join track_for_collection tfc on tfc.collection_id = mc.id 
join track t on tfc.track_id = t.id 
join album a on t.album_id = a.id 
join album_performers ap on a.id = ap.album_id 
join list_of_performers lop on ap.nickname_id = lop.id 
where lop.nickname = 'Queen'; 

--название альбомов, в которых присутствуют исполнители более 1 жанра

select album_name from album a 
join album_performers ap on a.id = ap.album_id 
join list_of_performers lop on ap.nickname_id = lop.id 
join genre_performers gp on lop.id = gp.performers_id 
group by a.album_name
having count(genre_id) > 1;

-- наименование треков, которые не входят в сборники

select track_name from track t 
full join track_for_collection tfc on t.id = tfc.track_id 
where collection_id is null;

--исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)

select nickname, album_name, duration, track_name from list_of_performers lop 
join album_performers ap on lop.id = ap.nickname_id 
join album a on ap.album_id = a.id 
join track t on a.id = t.album_id 
where duration = (select min(duration) from track);

--название альбомов, содержащих наименьшее количество треков

select album_name from album a 
join track t  on a.id = t.album_id 
group by album_name
having count(track_name) = ( 
	select min(track_count) from 
		(select count(track_name) as track_count from album a
		join track t  on a.id = t.album_id 
		group by album_name) as f)
	




 