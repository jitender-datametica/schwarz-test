CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_WEWA_BNK 
(
   MANDANT_ID,
	ART_ID,
	GP_ID,
	WEWA_BELEG_ID,
	WEWA_BELEG_POS_ID,
	WEWA_JAHR,
	KONDITIONSART_ID,
	DAT_BUCH,
	WUP_ID,
	NB_ID,
	BETRAG_BNK,
	WEWA_BETRAG_BNK_ZL,
	WEWA_BETRAG_BNK_DZ,
	WEWA_BETRAG_BNK_RET_ZL,
	WEWA_BETRAG_BNK_RET_DZ,
	VORZ,
	POSTEN_KZ_PER
)AS
   SELECT
   v01.mandant_id,
   v01.art_id,
   v01.gp_id,
   v01.wewa_beleg_id,
   v01.wewa_beleg_pos_id,
   v01.wewa_jahr,
   v02.konditionsart_id,
   v01.dat_buch,
   v01.wup_id,
   v01.nb_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN v02.soll_haben_kz = 'H' THEN 1 ELSE -1  END * CAST( CASE WHEN v200.wrg_typ_id  = 1 THEN v02.betrag_kondition
        WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 0 THEN v02.betrag_kondition* v300.umrechnungskurs
        WHEN v200.wrg_typ_id = 0 AND v200.berichtskurs_typ_id = 1 THEN v02.betrag_kondition* v400.umrechnungskurs
        END AS DECIMAL(18,6))   AS betrag_bnk,
   CASE WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = -111 THEN betrag_bnk END AS wewa_betrag_bnk_zl,
   CASE WHEN lager_bewart_id IN (101, 102, 901, 902) AND nb_id = 0      THEN betrag_bnk END AS wewa_betrag_bnk_dz,
   CASE WHEN lager_bewart_id IN (161, 162) AND nb_id = -111 THEN betrag_bnk END     AS wewa_betrag_bnk_ret_zl,
   CASE WHEN lager_bewart_id IN (161, 162) AND nb_id = 0      THEN betrag_bnk END     AS wewa_betrag_bnk_ret_dz,
   CASE WHEN v02.soll_haben_kz   = 'H' THEN 1 ELSE -1  END vorz,
   CASE
   WHEN v04.POSTEN_ID NOT IN ('1') THEN 'SO' ELSE 'PN'END :: CHAR(2) AS posten_kz_per

   FROM dbp_view.v_wewa v01
   INNER JOIN dbp_view.v_best_belegfluss_bnk  v02
   ON
   v01.mandant_id                 =   v02.mandant_id               AND
   v01.wewa_beleg_id           =   v02.folge_beleg_id          AND
   v01.wewa_beleg_pos_id   =   v02.folge_beleg_pos_id   AND
   v01.wewa_jahr                  =    v02.kj
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

/*JOIN dbp_view.v_kurs v300
   ON v01.dat_buch BETWEEN v300.dat_von AND v300.dat_bis
   AND v02.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 9
   AND v300.nach_wrg_id ='EUR'*/

   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs v300
   ON v300.dat_bis = '9999-12-31'
   AND v02.wrg_id = v300.von_wrg_id
   AND v300.kurstyp_id = 3
   AND v300.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs v400
   ON v01.dat_buch BETWEEN v400.dat_von AND v400.dat_bis
   AND v02.wrg_id = v400.von_wrg_id
   AND v400.kurstyp_id = 3
   AND v400.nach_wrg_id ='EUR'

   LEFT JOIN dbp_view.v_art_per v04
   ON v01.art_id = v04.art_id
   AND v01.mandant_id = v04.mandant_id
   AND v01.dat_buch BETWEEN v04.dat_von-1 AND v04.dat_bis-1 

   WHERE
   -- best_entw_typ_id  = 'C' ==> BNK
   v02.best_entw_typ_id  = 'C'

   -- v01.menge_basis  <>  0 keine Berücksichtigung von Storno
   AND  v01.menge_basis  <>  0
   AND v01.mandant_id <> 1;