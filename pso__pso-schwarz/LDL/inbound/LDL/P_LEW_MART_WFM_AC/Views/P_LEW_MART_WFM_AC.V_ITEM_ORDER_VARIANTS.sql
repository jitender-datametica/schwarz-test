CREATE OR REPLACE VIEW P_LEW_MART_WFM_AC.V_ITEM_ORDER_VARIANTS
(
    client_id
    , mandant
    , betriebsgesellschaft
    , sammelartikel
    , artikelvariante
    , artikelart
    , belieferart
    , bestellbereich
    , valid_var
    , artikelstatus
    , basis_me
    , anliefer_me
    , zaehler
    , nenner
    , unter_me
    , log_variante
)
AS
SELECT
client_id,
mandant,
betriebsgesellschaft,
sammelartikel,
artikelvariante,
artikelart,
belieferart,
bestellbereich,
valid_var,
artikelstatus,
basis_me,
anliefer_me,
zaehler,
nenner,
unter_me,
log_variante
FROM p_lew_mart_wfm.v_item_order_variants
;


