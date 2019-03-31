---------------------------------------------------------------- 1
SELECT yr, subject, winner
FROM nobel
WHERE yr = 1950
---------------------------------------------------------------- 2
SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'
---------------------------------------------------------------- 3
SELECT yr, subject
FROM nobel
WHERE winner = 'Albert Einstein'
---------------------------------------------------------------- 4
SELECT winner
FROM nobel
WHERE yr >= 2000
AND subject = 'Peace'
---------------------------------------------------------------- 5
SELECT * 
FROM nobel
WHERE subject = 'Literature'
AND yr BETWEEN 1980 AND 1989
---------------------------------------------------------------- 6
SELECT * 
FROM nobel
WHERE winner IN ('Theodore Roosevelt','Woodrow Wilson','Jimmy Carter','Barack Obama')
---------------------------------------------------------------- 7
SELECT winner
FROM nobel
WHERE winner LIKE 'John%'
---------------------------------------------------------------- 8
SELECT yr, subject, winner
FROM nobel
WHERE (subject='Physics' AND yr='1980')
OR (subject='Chemistry' AND yr='1984')
---------------------------------------------------------------- 9
SELECT yr, subject, winner
FROM nobel
WHERE yr='1980'
AND subject NOT IN ('Chemistry', 'Medicine')
---------------------------------------------------------------- 10
SELECT yr, subject, winner
FROM nobel
WHERE (subject='Medicine' AND yr < 1910)
OR (subject='Literature' AND yr >= 2004)
---------------------------------------------------------------- 11
SELECT yr, subject, winner
FROM nobel
WHERE winner='Peter Grünberg'
---------------------------------------------------------------- 12
SELECT yr, subject, winner
FROM nobel
WHERE winner='Eugene O''Neill'
---------------------------------------------------------------- 13
SELECT winner, yr, subject
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER by yr DESC, winner ASC -- It is possible to ORDER BY several columns. The first column mentionned will be the first sort.
---------------------------------------------------------------- 14
SELECT winner, subject
FROM nobel
WHERE yr=1984
ORDER BY subject IN ('Physics','Chemistry'), subject, winner -- subject IN ('Physics','Chemistry') will return 1 or 0 if true or not. It can be therefore used in ORDER BY