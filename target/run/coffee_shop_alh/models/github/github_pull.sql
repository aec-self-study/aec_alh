

  create or replace view `aec-students`.`dbt_alh`.`github_pull`
  OPTIONS()
  as select *
from `analytics-engineers-club.github.pull_request`
limit 100;

