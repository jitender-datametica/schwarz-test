CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTBEW_WG_MO_GP_SUM_OSEC_2
(
bewart_id
,kjmo
,mandant_id
,VK_Menge
,nb_id
,umsatz_mwst_betrag
,umsatz_netto
,wg_id
,wup_id
,arthiertyp_id
,posten_id
)
AS
   SELECT BEWART_ID ,
       KJMO ,
       MANDANT_ID ,
       CAST(MENGE AS NUMBER(38,5)) ,
       NB_ID ,
       CAST(UMSATZ_MWST_BETRAG AS NUMBER(38,5)) ,
       CAST(UMSATZ_NETTO AS NUMBER(38,5)) ,
       WG_ID ,
       WUP_ID ,
       ARTHIERTYP_ID ,
       CASE
          WHEN BEWART_ID = 1001 AND POSTEN_ID <> 'PN' 
             THEN ''
             ELSE 'PN'
       END  :: CHAR(2) AS POSTEN_ID_ 
FROM DBP_VIEW.V_ARTBEW_WG_MO_SUM_2
WHERE MANDANT_ID=1
  AND ARTHIERTYP_ID = 2 ;