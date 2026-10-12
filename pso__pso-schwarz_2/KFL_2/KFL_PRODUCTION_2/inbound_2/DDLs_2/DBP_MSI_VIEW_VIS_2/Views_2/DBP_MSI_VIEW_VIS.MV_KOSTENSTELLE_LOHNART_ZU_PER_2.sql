CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_KOSTENSTELLE_LOHNART_ZU_PER_2(
  MANDANT_ID
, ANZAHL_LOHNART
, BETRAG_LOHNART
, KJMO
, KOSTENSTELLE_ID
, KRK_ID
, LOHNART_ID
, WRG_ID
) AS
 -- 2022-10-04 ssch0611 : Calculation EUR with new logic [P16167]
 
  SELECT
    v01.mandant_id
  , v01.anzahl_lohnart
  , v01.betrag_lohnart * krs.umrechnungskurs AS betrag_lohnart
  , v01.kjmo
  , v01.kostenstelle_id
  , v01.krk_id
  , v01.lohnart_id
  , krs.nach_wrg_id AS wrg_id
  
  FROM dbp_view.v_kostenstelle_lohnart_zu_per_2 v01
  
  INNER JOIN ( 
    SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
    FROM dbp_data.kurs_2 krs1 
    WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
    AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
    UNION ALL 
    SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
    FROM dbp_data.kurs_2 krs2 
    WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
    AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
  ) krs  
  ON krs.von_wrg_id = v01.wrg_id
; 