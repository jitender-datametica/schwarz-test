CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ZAHLUNGSMITTEL_SPR_ZU_1
(
mandant_id
,zahlungsmittel_id
,zahlungsmittel_bez
,zahlungsmittel_bez_de
,zahlungsmittel_bez_cz
,zahlungsmittel_bez_pl
,zahlungsmittel_bez_sk
,zahlungsmittel_bez_hr
,zahlungsmittel_bez_ro
,zahlungsmittel_bez_bg
)
AS
   SELECT
   v01.mandant_id, v01.zahlungsmittel_id, MAX(CASE WHEN v01.spr_id =  22 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez, MAX(CASE WHEN v01.spr_id =  22 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez_de, MAX(CASE WHEN v01.spr_id = 124 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez_cz, MAX(CASE WHEN v01.spr_id =  90 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez_pl, MAX(CASE WHEN v01.spr_id = 108 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez_sk, MAX(CASE WHEN v01.spr_id =  65 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez_hr, MAX(CASE WHEN v01.spr_id =  95 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez_ro, MAX(CASE WHEN v01.spr_id =  18 THEN v01.zahlungsmittel_bez ELSE NULL END) AS zahlungsmittel_bez_bg
   FROM dbp_v_ods.v_zahlungsmittel_spr_zu_1 v01
   GROUP BY v01.mandant_id
   ,v01.zahlungsmittel_id;