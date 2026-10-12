CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTBEW_OSEC_2
(
art_id
,bewart_id
,dat
,gp_id
,herst_id
,mandant_id
,mwst_id
,nb_id
,umsatz_mwst_betrag
,umsatz_netto
,VK_Menge
,wrg_2
,wup_id
,bezugsweg_id
,aktion_id
, posten_id
)
AS
   SELECT
  art_id, bewart_id, dat, gp_id, herst_id, mandant_id, mwst_id, nb_id, CAST(umsatz_mwst_betrag AS NUMBER(38,5)), 
  CAST(umsatz_netto AS NUMBER(38,5)), CAST(menge AS NUMBER(38,5)), wrg_2, wup_id, bezugsweg_id, aktion_id 
  --CAST(TRANSLATE(CASE WHEN bewart_id = 1001 AND posten_id <> 'PN' THEN '  ' ELSE 'PN' END USING unicode_to_latin) AS CHAR(2)) AS posten_id_
  ,CASE
     WHEN bewart_id = 1001 AND posten_id <> 'PN'
     THEN ''
      ELSE 'PN'
   END  AS posten_id_

   FROM
   dbp_view.v_artbew_2
   WHERE mandant_id = 1
   and bewart_id = 1001;