CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTBEW_WG_TAG_SUM_OSEC
(
dat
,wg_id
,arthiertyp_id
,bewart_id
,mandant_id
,wup_id
,nb_id
,umsatz_mwst_betrag
,umsatz_netto
,VK_Menge
,posten_id
)
AS
  SELECT
      dat, 
      wg_id, 
      arthiertyp_id, 
      bewart_id, 
      mandant_id, 
      wup_id, 
      nb_id, 
      CAST(umsatz_mwst_betrag AS NUMBER(38,5)), 
      CAST(umsatz_netto AS NUMBER(38,5)), 
      CAST(menge AS NUMBER(38,5)), 
      CASE 
          WHEN bewart_id = 1001 AND posten_id <> 'PN' THEN '' 
          ELSE 'PN' 
          END 
        AS posten_id_
      -- CAST(TRANSLATE(CASE WHEN bewart_id = 1001 AND posten_id <> 'PN' THEN '  ' ELSE 'PN' END USING unicode_to_latin) AS CHAR(2)) AS posten_id_
   FROM
   dbp_view.v_artbew_wg_tp2_sum
   WHERE mandant_id = 1
   AND arthiertyp_id = 2
   ;