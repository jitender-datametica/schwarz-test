CREATE OR REPLACE VIEW DBP_MSI_VIEW_LIN.MV_TS_LIN_KURS_SPR_ZU_BG
-- 03.02.2020, srom0404, AP0052703, SPEC0068452, Ersetzen des Kennzeichen UWL, durch EWL und GSL 
(
 mandant_id
,lin_kurs_id
,mandant_lin_kurs_id
,lin_kurs_bez_land
)
AS
SELECT v1.mandant_id
      ,v1.lin_kurs_id
      ,Cast(v1.mandant_id AS CHAR(1)) ||' '||v2.lin_kurs_id AS mandant_lin_kurs_id
      ,v2.lin_kurs_bez ||' '|| mandant_kbez AS lin_kurs_bez_land
FROM dbp_view.v_l_lin_kurs v1 
INNER JOIN dbp_view.v_lin_kurs_spr_zu v2
   ON v1.lin_kurs_id = v2.lin_kurs_id        
INNER JOIN dbp_view.v_mandant v3
   ON v1.mandant_id = v3.mandant_id
WHERE v2.spr_id = 18
  AND (v1.lin_bericht IN ('EWL', 'GSL')
       OR v1.lin_bericht IS NULL
      )
GROUP BY v1.mandant_id
        ,v1.lin_kurs_id
        ,mandant_lin_kurs_id
        ,lin_kurs_bez_land;