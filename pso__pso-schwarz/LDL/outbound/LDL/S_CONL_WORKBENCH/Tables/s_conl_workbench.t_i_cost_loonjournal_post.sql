CREATE TABLE IF NOT EXISTS ldl_s_conl_workbench.t_i_cost_loonjournal_post (
booking_year STRING(5),
booking_period STRING(2),
account_number STRING(35),
cost_center_desc STRING(15),
pay_component STRING(25),
staff_number INTEGER,
debit_amount BIGNUMERIC(38,5),
credit_amount BIGNUMERIC(38,5)
);