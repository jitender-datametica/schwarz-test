CREATE OR REPLACE VIEW P_LEW_CORE_AC.V_ORDER_AREA
(
    client_id
    , order_area_sid
    , src_ekgrp
    , src_bestbereichnr
    , order_area_nr
    , order_area_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
) AS
SELECT
    client_id
    , order_area_sid
    , src_ekgrp
    , src_bestbereichnr
    , order_area_nr
    , order_area_name
    , dwh_load_id
    , dwh_created
    , dwh_updated
FROM p_lew_core.t_order_area ;