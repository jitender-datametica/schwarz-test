CREATE TABLE P_LEW_MART_LEAD.T_ITEM_PRPTY_LST_HST_1
(
client_id INTEGER,
item_sid INTEGER,
item_prpty_lst_id INTEGER,
dat_valid_from DATE,
dat_valid_to DATE,
item_prpty_lst_id_curr INTEGER)
/*** MSC-WARNING - MSCEWI2008 - PERFORMANCE REVIEW - CLUSTER BY ***/
/*CLUSTER BY(RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 ,
NO RANGE), RANGE_N(dat_valid_from BETWEEN '2006-01-01' AND '9999-12-31' EACH INTERVAL '1 day' ,
NO RANGE))*/;


