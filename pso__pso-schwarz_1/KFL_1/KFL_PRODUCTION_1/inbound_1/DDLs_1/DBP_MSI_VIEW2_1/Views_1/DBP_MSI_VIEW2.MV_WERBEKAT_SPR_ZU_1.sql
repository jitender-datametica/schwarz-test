CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_WERBEKAT_SPR_ZU_1
(
werbe_kat_id
,mandant_id
,sap_werbe_kat_id
,spr_id
,werbe_kat_bez
,sap_werbe_kat_bez
)
AS
   SELECT
  v01.werbe_kat_id, v01.mandant_id, v01.sap_werbe_kat_id, v02.spr_id, v02.werbe_kat_bez, cast (v01.sap_werbe_kat_id as varchar(10)) || '   ' || v02.werbe_kat_bez as sap_werbe_kat_bez

   FROM dbp_view.v_l_werbekat_1 AS v01
   INNER JOIN dbp_view.v_werbekat_spr_zu_1 AS v02
   ON
   v01.werbe_kat_id = v02.werbe_kat_id
   AND
   v01.mandant_id = v02.mandant_id
   WHERE
   v01.mandant_id = 1
   AND
   v02.spr_id = 22;