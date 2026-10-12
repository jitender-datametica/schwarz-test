CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_F_FINANCIAL_2(
  BON_ID
 ,BON_DAT
 ,BON_BOOKING
 ,DAT_BOOKING
 ,WUP_ID
 ,MANDANT_ID
 ,KASSE_NR
 ,KUNDE_FG
 ,BON_BEGINN
 ,BON_ENDE
 ,TURNOVER_FG
 ,WRG_ID
 ,KASSE_TYP_ID
 ,BON_ZEILE
 ,KL_ART_ID
 ,EAN_KASSE
 ,MENGE
 ,EINH_ID
 ,UMSATZ_BRUTTO
 ,REKLAMATIONSGRUND_ID
 ,REKLAMATIONSTYP_ID
 ,AUSZAHLUNG_FG
) AS
 
	-- Fakt-View
	-- Gefiltert, d.h. nur nicht stornierte Bons enthalten
	-- 2022-09-30 ssch0611 : Calculation EUR with new logic [P16167]
 	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
 
SELECT
 k.bon_id
 , k.bon_dat
 , k.bon_booking
 , k.dat_booking
 , wup.aktuell_wup_id 															AS wup_id
 , k.mandant_id
 , k.kasse_nr
 , k.kunde_fg
 , k.bon_beginn
 , k.bon_ende
 , k.turnover_fg
 , krs.nach_wrg_id 																AS wrg_id
 , k.kasse_typ_id
 , f.bon_zeile
 , -1                                    										AS kl_art_id 				-- Dummy_2- KL-Artikel_2
 , CAST(-1 AS DECIMAL(18,0))             										AS ean_kasse 				-- Dummy_2- EAN_2
 , SIGN(f.umsatz_brutto)::DECIMAL(18,3)  										AS menge   					-- Menge ist 1 oder -1 (financial.umsatz_brutto)
 , CAST('ST' AS CHAR(3))                 										AS einh_id 					-- Default Einheit = Stueck
 , f.umsatz_brutto * krs.umrechnungskurs 										AS umsatz_brutto 
 , f.financial_grund_id                  										AS reklamationsgrund_id
 , CAST('-1' AS CHAR(2))                 										AS reklamationstyp_id
 , f.auszahlung_fg
   --, f.financial_kommentar  -- not used 
FROM dbp_v_ods.v_ods_bon_kopf_2 k
 
INNER JOIN dbp_v_ods.v_ods_bon_financial_2 f
ON  k.bon_id     = f.bon_id
AND k.wup_id     = f.wup_id
AND k.mandant_id = f.mandant_id

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
ON krs.von_wrg_id = k.WRG_ID

INNER JOIN dbp_view.v_wup_2 wup_2
ON k.mandant_id = wup.mandant_id AND k.wup_id = wup.wup_id

WHERE (k.bon_id, k.wup_id, k.mandant_id) NOT IN (SELECT 
 bon_id
 , wup_id
 , mandant_id 
FROM dbp_v_ods.v_ods_bon_storno_2
)
;