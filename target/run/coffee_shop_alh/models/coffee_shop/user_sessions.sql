

  create or replace view `aec-students`.`dbt_alh`.`user_sessions`
  OPTIONS()
  as with source as (

    select * from `analytics-engineers-club`.`web_tracking`.`pageviews`

),
  base AS (
  SELECT
    id,
    customer_id,
    FIRST_VALUE(visitor_id) OVER (PARTITION BY customer_id ORDER BY timestamp ASC) AS vistor_id,
    device_type,
    timestamp AS ts,
    TIMESTAMP_DIFF(timestamp, LAG(timestamp) OVER (ORDER BY timestamp), MINUTE) AS time_difference,
    CASE
      WHEN TIMESTAMP_DIFF(timestamp, LAG(timestamp) OVER (PARTITION BY customer_id ORDER BY timestamp), MINUTE) >= 30 OR LAG(timestamp) OVER (PARTITION BY customer_id ORDER BY timestamp) IS NULL THEN TRUE
    ELSE
    FALSE
  END
    AS new_session,
    page
  FROM
    `analytics-engineers-club.web_tracking.pageviews`
  WHERE
    customer_id IS NOT NULL
  ORDER BY
    2,
    timestamp),
  session_id AS (
  SELECT
    *,
    SUM(
    IF
      (new_session, 1, 0)) OVER (PARTITION BY customer_id ORDER BY ts) AS session_id
  FROM
    base),
  rank_within_pgvws AS (
  SELECT
    *,
    ROW_NUMBER() OVER (PARTITION BY session_id.session_id ORDER BY ts DESC) AS session_row_num
  FROM
    session_id
  ORDER BY
    ts,
    session_id )
SELECT
  *,
  CASE
    WHEN new_session = TRUE THEN ts
END
  AS session_start_ts,
  CASE
    WHEN session_row_num = 1 THEN ts
END
  AS session_end_ts
FROM
  rank_within_pgvws;

