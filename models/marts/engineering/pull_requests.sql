with 

pull_request as (
    select * from {{ ref('stg_github_pull_request')}}
), 
repositories as (
    select * from {{ ref('stg_github_repository')}}
),issues as (
    select * from {{ ref('stg_github_issue')}}
),issues_merged as (
    select * from {{ ref('stg_github_issue_merged')}}
),final as (

select 

pull_requests.pull_request_id,
repository.name as repo_name,
issues.number as pull_request_number,
--find out how to label pull requests with type
cast(null as string) as type,

case 
    when pull_requests.is_draft then 'draft'
    when issues_merged.merged_at is not null then 'merged'
    when issues.closed_at is not null then 'closed_without_merge'
    else 'open'
end as state,
--
issues.created_at as opened_at,
issues_merged.merged_at, 
date_diff(issues.created_at, issues_merged.merged_at, hour) / 24.0 as days_open_to_merge

from pull_request as pull_requests

left join repositories repository
    on pull_requests.head_repo_id = repository.repo_id
left join issues as issues 
    on pull_requests.issue_id = issues.issue_id
left join issues_merged issues_merged
    on pull_requests.issue_id = issues_merged.issue_id
)

select * from final