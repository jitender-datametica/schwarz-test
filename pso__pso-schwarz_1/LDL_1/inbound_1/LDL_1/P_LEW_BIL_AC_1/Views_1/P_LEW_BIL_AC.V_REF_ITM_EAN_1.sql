CREATE OR REPLACE VIEW P_LEW_BIL_AC.V_REF_ITM_EAN_1
(
    client_id
    , loc_sid_wh
    , wh_id
    , item_sid
    , orig_item_nr
    , gtin_input_cd
    , barcode
    , case_factor_ejr
    , dwh_valid_from
    , dwh_valid_to
)
AS
   SELECT
       client_id,
   loc_sid_wh,
   wh_id,
   item_sid,
   orig_item_nr,
   gtin_input_cd,
   barcode,
   case_factor_ejr,
   dwh_valid_from,
   dwh_valid_to

  FROM p_lew_bil.v_ref_itm_ean_1
;