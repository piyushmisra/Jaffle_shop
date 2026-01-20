with payments as (

select * from {{ ref('stg_stripe__payments') }}

),

orders as (

select * from {{ ref('stg_jaffle_shop__orders') }}

),

order_payments as (

select 
        orders.order_id,
        orders.customer_id,
        orders.order_date,

        payments.payment_method,
        payments.status,
        payments.amount / 100 as amount,
        payments.created_as

 from orders
inner join payments using (order_id)

),

customers as (

select * from {{ ref('stg_jaffle_shop__customers') }}

),



final as (

    select
        customers.customer_id,
        order_payments.order_id,
        order_payments.amount
    from customers
    left join order_payments using (customer_id)

)

select * from final