CREATE OR REPLACE VIEW DBP_MSI_VIEW2.MV_ARTBEW_MO_SUM_OSEC_1
(
kjmo
,art_id
,bewart_id
,mandant_id
,wup_id
,nb_id
,gp_id
,herst_id
,umsatz_mwst_betrag
,umsatz_netto
,VK_Menge
,posten_id
)
AS
   SELECT KJMO ,
       ART_ID ,
       BEWART_ID ,
       MANDANT_ID ,
       WUP_ID ,
       NB_ID ,
       GP_ID ,
       HERST_ID ,
       CAST(UMSATZ_MWST_BETRAG AS NUMBER(38,5)) ,
       CAST(UMSATZ_NETTO AS NUMBER(38,5)) ,
       CAST(MENGE AS NUMBER(38,5)) ,
       CASE
           WHEN BEWART_ID = 1001 AND POSTEN_ID <> 'PN' 
              THEN ''
              ELSE 'PN'
       END  :: CHAR(2) AS POSTEN_ID_ 
FROM DBP_VIEW.V_ARTBEW_MO_SUM_1
WHERE MANDANT_ID = 1;