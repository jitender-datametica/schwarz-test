CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_TECHN_PLATZ_OBL_BASIS_HIST_2
AS
   SELECT
        tp.techn_platz_id, pr.projekt_id, tp.mandant_id, tp_s.tech_platz_bez, tp2.tp_vl_name, tp2.tp_vkl_name, tp2.tp_ol_vermietung, tp2.tp_bl_kbl_name, tp2.tp_betreuer_kbl_name, tp2.tp_betreuer_handy_nr, tp2.tp_betreuer_hls_name, tp2.tp_betreuer_elektro_name, pr.cpr_bl_projekt_bau_einr_name AS tp_bl_projekt_name, pr.pl_be_name  AS tp_pl_kbl, "CURRENT_DATE" - 14 AS dat_extrakt
   FROM dbp_view.v_techn_platz_per_2 tp
   INNER JOIN dbp_view.v_techn_platz_ebene_2_per_2 tp2
   ON
   tp.techn_platz_id       = tp2.techn_platz_id
   AND tp.techn_platz_ebene_id = 2
   AND tp.wup_stadt            IS NOT NULL
   INNER JOIN dbp_view.v_techn_platz_spr_zu_per_2 tp_s
   ON
   tp.techn_platz_id = tp_s.techn_platz_id
   AND tp_s.spr_id       = 22
   CROSS JOIN

   (SELECT

   --  Der Ausdruck liefert Datum des historischhen Vergleichs.
   --  Ursprünglich wurde  die Vergleichsdaten jeden 15 des Monats abgelegt und
   --  dienten als den Vergleichswert.
   -- Am 20.mm_2 wird  14.mm_2  durch CASE Audruck erzeugt
   -- AM 07.mm_2  wird  14.(mm_2-1)  durch CASE Audruck erzeugt
   CASE WHEN DAY(CURRENT_DATE()) >= 15 THEN DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, CURRENT_DATE())
   ELSE DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, DATEADD(Month, -1, CURRENT_DATE()))
   END  hist_date ) hst
   --CASE    WHEN EXTRACT(day from date) >= 15 THEN date - extract(day from date) + 14
   --ELSE  add_months (date , -1) - EXTRACT(day from date) +14
   --END  hist_date ) hst
   LEFT OUTER JOIN
   (
   SELECT
   pr0.mandant_id, pr0.techn_platz_id, pr0.pl_be_name, pr0.cpr_bl_projekt_bau_einr_name, pr0.projekt_id
   FROM dbp_view.v_cpr_projekt_per_2 pr0,
   (SELECT

   --  Der Ausdruck liefert Datum des historischhen Vergleichs.
   --  Ursprünglich wurde  die Vergleichsdaten jeden 15 des Monats abgelegt und
   --  dienten als den Vergleichswert.
   -- Am 20.mm_2 wird  14.mm_2  durch CASE Audruck erzeugt
   -- AM 07.mm_2  wird  14.(mm_2-1)  durch CASE Audruck erzeugt
   CASE WHEN DAY(CURRENT_DATE()) >= 15 THEN DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, CURRENT_DATE())
   ELSE DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, DATEADD(Month, -1, CURRENT_DATE()))
   END  hist_date ) hst

   WHERE pr0.cpr_standort IS NOT NULL
   AND hist_date BETWEEN pr0.dat_von AND pr0.dat_bis

   ) pr
   ON  tp.techn_platz_id = pr.techn_platz_id
   AND tp.mandant_id     = pr.mandant_id

   WHERE        hst.hist_date BETWEEN tp.dat_von AND tp.dat_bis
   AND hst.hist_date BETWEEN tp_s.dat_von AND tp_s.dat_bis
   AND hst.hist_date BETWEEN tp2.dat_von AND tp2.dat_bis

   UNION

   SELECT
   pr.techn_platz_id, pr.projekt_id, pr.mandant_id, pr_s.cpr_projekt_bez AS tech_platz_bez, ''                   AS tp_vl_name, ''                   AS tp_vkl_name, ''                   AS tp_ol_vermietung, ''                   AS tp_bl_kbl_name, ''                   AS tp_betreuer_kbl_name, ''                   AS tp_betreuer_handy_nr, ''                   AS tp_betreuer_hls_name, ''                   AS tp_betreuer_elektro_name, pr.cpr_bl_projekt_bau_einr_name  AS tp_bl_projekt_name, pr.pl_be_name        AS tp_pl_kbl, CURRENT_DATE                 AS dat_extrakt
   FROM dbp_view.v_cpr_projekt_per_2 pr
   INNER JOIN dbp_view.v_cpr_projekt_spr_zu_per_2 pr_s
   ON
   pr.projekt_id = pr_s.projekt_id
   AND pr_s.spr_id   = 22
   CROSS JOIN
   (SELECT

   CASE WHEN DAY(CURRENT_DATE()) >= 15 THEN DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, CURRENT_DATE())
   ELSE DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, DATEADD(Month, -1, CURRENT_DATE()))
   END  hist_date ) hst

   WHERE
   pr.techn_platz_id NOT IN
   (
   SELECT
   tp0.techn_platz_id  techn_platz_id
   FROM dbp_view.v_techn_platz_per_2  tp0
   CROSS JOIN
   (SELECT

   CASE WHEN DAY(CURRENT_DATE()) >= 15 THEN DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, CURRENT_DATE())
   ELSE DATEADD(day, -1 * DAY(CURRENT_DATE()) + 14, DATEADD(Month, -1, CURRENT_DATE()))
   END  hist_date ) hst

   WHERE
   tp0.wup_stadt IS NOT NULL
   AND tp0.techn_platz_ebene_id = 2
   AND hist_date  BETWEEN tp0.dat_von AND tp0.dat_bis

   )
   AND pr.cpr_standort IS NOT NULL
   AND hist_date BETWEEN pr.dat_von AND pr.dat_bis
   AND hist_date BETWEEN pr_s.dat_von AND pr_s.dat_bis;