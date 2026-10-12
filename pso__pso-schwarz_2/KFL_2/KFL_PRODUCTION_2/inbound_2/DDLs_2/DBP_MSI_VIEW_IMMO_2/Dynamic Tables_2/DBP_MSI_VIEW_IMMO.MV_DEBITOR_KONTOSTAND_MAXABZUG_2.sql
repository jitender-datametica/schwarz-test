CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW_IMMO.MV_DEBITOR_KONTOSTAND_MAXABZUG_2(
	MANDANT_ID,
	DEBITOR_ID,
	KJMO,
	MIETVERTRAG_ID,
	ABZUG_ID,
	SALDO_VORTRAG,
	SUMME_SOLL,
	SUMME_HABEN,
	SUMME_HABEN_ABZUG_10,
	SUMME_HABEN_ABZUG_20,
	SUMME_HABEN_ABZUG_30,
	SUMME_HABEN_ABZUG_0,
	SALDO_SOLL,
	SALDO_HABEN,
	SALDO_KONTO,
	WRG_ID,
	WRG_TYP_ID,
	BRANCHE_ID
) 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_IMMO

 AS
 -- 2009-06-15
 -- FAKTVIEW Debitor Kontostand/Salden (KJMO)
 -- 2009KW17 EUR + LW über waehrungstyp
 -- 2009KW27 Historisierung Kurs_2
 -- 2009KW47 Umstellung mv_zeit_2 auf v_monat_2
 -- 2013-04-11 : Redesign Offene Posten + Mietsicherheiten
 -- 20200709 SPEC0081244 sanadze: Initialisierung
 -- 20201110 SPEC0089773 sanadze: das Feld "wup_id" hinzugefügt
 -- 20201203 SPEC0089773 sanadze: "wup_id" ersetz mit "mietvertrag_id"
 -- 20210520 richternic: Anpassung Inner JOIN Mietvertag mitnehmen 
 -- 20210608 richternic: Branchen ID mitaufnehmen 
SELECT
  dk.mandant_id
, dk.debitor_id
, dk.kjmo
, dk.mietvertrag_id
, sub01.last_abzug_id         AS abzug_id
, dk.saldo_vortrag * kurs_2     AS saldo_vortrag
, dk.summe_soll * kurs_2        AS summe_soll
, dk.summe_haben * kurs_2       AS summe_haben
, sub01.summe_haben_10 * kurs_2 AS summe_haben_abzug_10
, sub01.summe_haben_20 * kurs_2 AS summe_haben_abzug_20
, sub01.summe_haben_30 * kurs_2 AS summe_haben_abzug_30
, sub01.summe_haben_0 * kurs_2  AS summe_haben_abzug_0
, dk.saldo_soll * kurs_2        AS saldo_soll
, dk.saldo_haben * kurs_2       AS saldo_haben
, dk.saldo_konto * kurs_2       AS saldo_konto
, kurs.wrg_id
, kurs.wrg_typ_id
, immo.BRANCHE_ID
FROM dbp_view.v_ivs_debitor_kontostand_2  dk

JOIN ( 
    SELECT
      mandant_id
    , debitor_id
    , kjmo
    , mietvertrag_id
    , CASE WHEN MIN(abzug_id) = 0 THEN 0 ELSE MAX(abzug_id) END AS last_abzug_id
    , SUM(CASE WHEN abzug_id = 10 THEN summe_haben ELSE 0 END)  AS summe_haben_10
    , SUM(CASE WHEN abzug_id = 20 THEN summe_haben ELSE 0 END)  AS summe_haben_20
    , SUM(CASE WHEN abzug_id = 30 THEN summe_haben ELSE 0 END)  AS summe_haben_30
    , SUM(CASE WHEN abzug_id =  0 THEN summe_haben ELSE 0 END)  AS summe_haben_0
    FROM dbp_view.v_ivs_debitor_kontostand_2
    
    GROUP BY
      mandant_id
    , debitor_id
    , kjmo
    , mietvertrag_id
) sub01
ON dk.mandant_id = sub01.mandant_id
AND dk.debitor_id = sub01.debitor_id
AND dk.kjmo = sub01.kjmo
AND dk.abzug_id = sub01.last_abzug_id
AND dk.mietvertrag_id = sub01.mietvertrag_id

LEFT JOIN dbp_view.v_immo_mietvertrag_per_2 immo
ON immo.mv_intreno = dk.mietvertrag_id
AND immo.mandant_id = dk.mandant_id 


INNER JOIN dbp_view.v_monat_2  zeit_2
ON zeit.kjmo = dk.kjmo

INNER JOIN dbp_msi_view_immo.mv_mand_wrg_kurs_zu_per_2  kurs_2
ON kurs.mandant_id = dk.mandant_id;