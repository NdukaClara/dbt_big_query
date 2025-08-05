with customers as (
    select id,
           first_name,
           last_name
    from `dbt-tutorial.jaffle_shop.customers`
),

orders as (
    select id,
           user_id,
           order_date,
           status
    from `dbt-tutorial.jaffle_shop.orders`
),

customer_orders as (
    select
        user_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(id) as number_of_orders
    from orders
    group by user_id
),

final as (
    select
        c.id,
        c.first_name,
        c.last_name,
        co.first_order,
        co.most_recent_order,
        co.number_of_orders
    from customers c
    left join customer_orders co
    on c.id = co.user_id
)

select * from final