CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_EKBZ_2
(
mandant_id
,BELNR
,BUZEI
,GJAHR
,EKBZ_BEWTP
,DMBTR
,KSCHL
,SHKKO
--,jahresbonus
--,bnk
)

AS
   SELECT
   mandant_id, folge_beleg_id          AS BELNR, folge_beleg_pos_id      AS BUZEI, kj                      AS GJAHR, best_entw_typ_id        AS EKBZ_BEWTP, (CASE WHEN soll_haben_kko = 'S' THEN -1 ELSE 1 END) * betrag_kondition AS DMBTR, konditionsart_id        AS KSCHL, soll_haben_kko          AS SHKKO
   --,(CASE WHEN soll_haben_kko = 'S' THEN -1 ELSE 1 END) * betrag_kondition * (CASE WHEN best_entw_typ_id = 'B' AND konditionsart_id IN ('A001','A002') THEN 1 ELSE 0 END) AS jahresbonus
   --,(CASE WHEN soll_haben_kko = 'S' THEN -1 ELSE 1 END) * betrag_kondition * (CASE WHEN best_entw_typ_id <> 'B' THEN 1 ELSE 0 END) AS bnk
   FROM
   dbp_view.v_best_belegfluss_bnk_2
   ;