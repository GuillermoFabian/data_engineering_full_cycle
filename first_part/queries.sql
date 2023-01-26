SELECT
	CAST(lpep_pickup_datetime AS DATE) as "day",
	MAX(trip_distance) as "distance"
FROM green_taxi
GROUP BY
	"day"
ORDER BY 2 desc
LIMIT 10;

SELECT
	CAST(lpep_pickup_datetime AS DATE) as "day",
	sum(case when passenger_count = 2 then 1 end) as p_2,
	sum(case when passenger_count = 3 then 1 end) as p_3
FROM green_taxi
WHERE CAST(lpep_pickup_datetime AS DATE) = '2019-01-01'
GROUP BY
	"day"
ORDER BY 2 desc
LIMIT 10;


WITH taxitrips AS
    (SELECT
    gt.*,
    zpu."LocationID" AS puID,
    zpu."Zone" AS puZON,
    zdo."LocationID" AS doID,
    zdo."Zone" AS doZON
    FROM
    green_taxi gt
    LEFT JOIN zones zpu
        ON gt."PULocationID" = zpu."LocationID"
    LEFT JOIN zones zdo
        on gt."DOLocationID" = zdo."LocationID"
    )
SELECT puID, puZON, doID, doZON, tip_amount AS trip_distance
FROM
  taxitrips
  where puzon = 'Astoria'

ORDER BY 5 DESC;