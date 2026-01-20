with payments as (

select * from {{ ref('stg_stripe__payment') }}

),

customers as (

select * from {{ ref('stg_jaffle_shop__customers') }}

),

orders as (

select * from {{ ref('stg_jaffle_shop__orders') }}

),


final as (

    select
        customers.customer_id,
        payments.order_id,
        payments.amount
    from customers
    left join payments using (customer_id)
    left join orders using (orderid)

)

select * from final