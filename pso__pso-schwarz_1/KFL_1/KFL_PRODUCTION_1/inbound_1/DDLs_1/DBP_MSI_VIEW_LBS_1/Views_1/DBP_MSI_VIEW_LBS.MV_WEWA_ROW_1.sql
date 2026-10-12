CREATE OR REPLACE VIEW DBP_MSI_VIEW_LBS.MV_WEWA_ROW_1(
	MANDANT_ID,
	RECH_BELEG_ID,
	RECH_BELEG_KONT_POS_ID,
	WUP_ID,
	NB_ID,
	GP_ID,
	DAT_BUCH,
	ART_ID,
	BETRAG_BELEG,
	WE_WERT_EKN_GOW,
	WEWA_JAHR,
	POSTEN_KZ_PER
) AS
SELECT
      BRK.MANDANT_ID,
      BRK.RECH_BELEG_ID,
      BRK.RECH_BELEG_KONT_POS_ID,
      COALESCE(BR.WUP_ID, 0) AS WUP_ID,
      COALESCE(BR.NB_ID, -1) AS NB_ID,
      BR.GP_ID,
      BR.DAT_BUCH,
      CAST(-2 AS INTEGER) ART_ID,
      -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
      CAST(
            CASE
                  WHEN BR.MANDANT_ID = 5 AND BR.KURSF < 0 THEN (BRK.BETRAG_BELEG / ABS(BR.KURSF))
                  WHEN V200.WRG_TYP_ID = 1 THEN BRK.BETRAG_BELEG * BR.KURSF
                  WHEN V200.WRG_TYP_ID = 0 AND V200.BERICHTSKURS_TYP_ID = 0 THEN BRK.BETRAG_BELEG * BR.KURSF * V300.UMRECHNUNGSKURS
                  WHEN V200.WRG_TYP_ID = 0 AND V200.BERICHTSKURS_TYP_ID = 1 THEN BRK.BETRAG_BELEG * BR.KURSF * V400.UMRECHNUNGSKURS
            END AS NUMBER(38,5)
      ) AS BETRAG_BELEG,
      CAST(0 AS DECIMAL(18, 4)) AS WE_WERT_EKN_GOW,
      BR.GJ AS WEWA_JAHR,
      CASE WHEN v04.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
FROM
      DBP_VIEW.V_BESCH_RECH_DET_KONT_1 BRK
      INNER JOIN DBP_VIEW.V_BESCH_RECH_1 BR 
      ON BRK.MANDANT_ID = BR.MANDANT_ID
      AND BRK.RECH_BELEG_ID = BR.RECH_BELEG_ID
      AND BRK.GJ = BR.GJ
      INNER JOIN DBP_VIEW.V_MANDANT_1 M 
      ON BRK.MANDANT_ID = M.MANDANT_ID 
      
      -- ERMITTLUNG DER EINGESTELLTER WÄHRUNG
      CROSS JOIN DBP_MSI.AKT_MSI_USER_WRG_TYP_ZU_1 V200
      
  /*  JOIN DBP_VIEW.V_KURS_1 V300 
      ON BR.DAT_BUCH BETWEEN V300.DAT_VON AND V300.DAT_BIS
      AND M.DEFAULT_WRG = V300.VON_WRG_ID
      AND V300.KURSTYP_ID = 9
      AND V300.NACH_WRG_ID = 'EUR' */

      
   -- JOIN aktueller Berichtskurs
   JOIN DBP_VIEW.V_KURS_1 V300
   ON V300.DAT_BIS = '9999-12-31'
   AND M.DEFAULT_WRG = V300.VON_WRG_ID
   AND V300.KURSTYP_ID = 3
   AND V300.NACH_WRG_ID ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN DBP_VIEW.V_KURS_1 V400
   ON BR.DAT_BUCH BETWEEN V400.DAT_VON AND V400.DAT_BIS
   AND M.DEFAULT_WRG = V400.VON_WRG_ID
   AND V400.KURSTYP_ID = 3
   AND V400.NACH_WRG_ID ='EUR'
   
      LEFT JOIN dbp_view.v_art_per_1 v04
      ON -2 = v04.art_id
      AND brk.mandant_id = v04.mandant_id
      AND br.dat_buch BETWEEN v04.dat_von-1 AND v04.dat_bis-1 
WHERE
      -- ENTSPRECHEND DEM IT KONZEPT DEFINIERTE UND FÜR ROW ZU BERÜCKSICHTIGENDE SACHKONTO
      (
            BRK.MANDANT_ID IN (2, 3, 5, 6)
            AND SACHKONTO_ID IN ('R097761', 'R097762', 'R097763')
      )
      OR (
            BRK.MANDANT_ID IN (7, 8)
            AND SACHKONTO_ID IN ('0000097761', '0000097762', '0000097763')
      )
UNION
ALL
SELECT
      V01.MANDANT_ID,
      V01.RECH_BELEG_ID,
      V01.RECH_BELEG_KONT_POS_ID,
      V02.WUP_ID,
      V02.NB_ID,
      V02.GP_ID,
      V02.DAT_LEIST_ERSTELLUNG AS DAT_BUCH,
      V03.ART_ID,
      CASE
            WHEN V01.BETRAG_BELEG > 0 THEN V01.BETRAG_BELEG
      END AS BETRAG_BELEG --WE_WERT_EKN_ROW MANDANT_ID = 1
,
      CASE
            WHEN V01.BETRAG_BELEG < 0 THEN V01.BETRAG_BELEG
      END AS WE_WERT_EKN_GOW,
      TO_NUMBER(SUBSTR(V02.DAT_LEIST_ERSTELLUNG, 1, 4)) AS WEWA_JAHR
,     CASE WHEN v04.posten_id NOT IN ('PN', 'PF', 'SP','1') THEN 'SO' ELSE 'PN' END :: CHAR(2) AS POSTEN_KZ_PER
FROM
      DBP_VIEW.V_BESCH_RECH_DET_KONT_1 V01
      LEFT OUTER JOIN DBP_VIEW.V_BESCH_RECH_1 V02 ON V01.RECH_BELEG_ID = V02.RECH_BELEG_ID
      AND V01.GJ = V02.GJ
      AND V01.MANDANT_ID = V02.MANDANT_ID
      JOIN DBP_VIEW.V_ART_WG_ZU_PER_1 V03 ON V01.WG_ID * -1000 = V03.ART_ID
      AND V01.MANDANT_ID = V03.MANDANT_ID
      AND V01.ARTHIERTYP_ID = V03.ARTHIERTYP_ID
      AND V03.DAT_BIS = '9999-12-31'
      LEFT JOIN dbp_view.v_art_per_1 v04
      ON v03.art_id = v04.art_id
      AND v01.mandant_id = v04.mandant_id
      AND v02.dat_leist_erstellung BETWEEN v04.dat_von-1 AND v04.dat_bis-1 
WHERE
      V01.MANDANT_ID = 1
      AND RIGHT(V01.SACHKONTO_ID,6) IN (
            '314602',
            '314603',
            '314604',
            '314605',
            '314606',
            '314607',
            '314608',
            '314609',
            '314610',
            '314611',
            '314612',
            '314616',
            '314617',
            '314621',
            '314622',
            '314623',
            '314624'
      )
      AND V01.ROW_GRUND_ID IN (
            '100',
            '101',
            '103',
            '104',
            '105',
            '106',
            '107',
            '108',
            '109',
            '110',
            '111',
            '112',
            '114',
            '116',
            '119',
            '120',
            '142',
            '160',
            '161',
            '199'
      );