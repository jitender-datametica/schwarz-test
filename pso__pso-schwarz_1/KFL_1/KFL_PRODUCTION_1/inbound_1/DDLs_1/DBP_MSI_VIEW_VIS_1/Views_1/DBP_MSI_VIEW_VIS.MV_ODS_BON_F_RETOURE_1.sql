CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_ODS_BON_F_RETOURE_1(
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
 ,BON_ZEILE
 ,KL_ART_ID
 ,EAN_KASSE
 ,MENGE
 ,EINH_ID
 ,UMSATZ_BRUTTO
 ,MWST
 ,REKLAMATIONSGRUND_ID
 ,REKLAMATIONSTYP_ID
 ,MENGE_FG
 ,MHD
 ,LOS_CHARGE
 ,KUNDEN_TEXT
 ,ART_ID_REF
 ,KPOS_ERFASSUNG_ID
) AS
 
	-- Fakt-View
	-- Gefiltert, d.h. nur nicht stornierte Bons enthalten
	-- 2014KW05 : Anpassung MWSt (ID anstelle Satz)
	-- 20140211 : Korrektur MWSt (Join auf LU)
	-- 20190819: Einfügen bon_dat in Join-Bedingung wegen Bondaten RDS
	-- 20200619: join MWST auf dat between geändert
	-- 31.08.2022, snik: WRG_1 updated with latest changes - PRJTASK0013908
	-- 2022-10-04 ssch0611 : Calculation EUR with new logic [P16167]
	-- 2023-05-22 snik1809 : turnover_fg = 1
	-- 2023-08-14 staeblern: SPEC0189820 entfernen  Kassentyp
 	-- 2024-06-20 beisswenger : Filialumgliederung + Review [P1760-DWH]
	-- 2024-10-16 muellerpatri : Filter auf wg_id <> 961 hinzugefügt [SPEC0276475]

SELECT
 k.bon_id
 , k.bon_dat
 , k.bon_booking
 , k.dat_booking
 , wup.aktuell_wup_id 																AS wup_id
 , k.mandant_id
 , k.kasse_nr
 , k.kunde_fg
 , k.bon_beginn
 , k.bon_ende
 , k.turnover_fg
 , krs.nach_wrg_id 																	AS wrg_id
 , r.bon_zeile
 , r.kl_art_id
 , r.ean_kasse
   -- ,r.wg_id
 , r.menge
 , r.einh_id
 , r.umsatz_brutto * krs.umrechnungskurs 											AS umsatz_brutto
 , m.mwst
   -- ,r.erfassung_id
   -- ,r.aktion_id
 , r.reklamationsgrund_id
 , r.reklamationstyp_id
 , r.menge_fg
 , r.mhd
 , r.los_charge
 , r.kunden_text
 , r.art_id_ref
 , r.kpos_erfassung_id
FROM dbp_v_ods.v_ods_bon_kopf_1 k
 
INNER JOIN dbp_v_ods.v_ods_bon_retoure_1 r
ON  k.bon_id     = r.bon_id
AND k.wup_id     = r.wup_id
AND k.mandant_id = r.mandant_id
AND k.bon_dat = r.bon_dat
 
INNER JOIN dbp_view.v_mwst_per_1 m
ON r.mandant_id = m.mandant_id
AND r.mwst_id = m.mwst_id
AND r.bon_dat BETWEEN m.dat_von AND m.dat_bis
 
INNER JOIN ( 
	 SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	 FROM dbp_data.kurs_1 krs1 
	 WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	 AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	 UNION ALL 
	 SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	 FROM dbp_data.kurs_1 krs2 
	 WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	 AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = k.wrg_id 

INNER JOIN dbp_view.v_wup_1 wup_1
ON k.mandant_id = wup.mandant_id AND k.wup_id = wup.wup_id
 
WHERE (k.bon_id, k.wup_id, k.mandant_id) NOT IN	(
	SELECT bon_id, wup_id, mandant_id 
	FROM dbp_v_ods.v_ods_bon_storno_1)
AND k.turnover_fg = 1
AND r.wg_id <> 961
;