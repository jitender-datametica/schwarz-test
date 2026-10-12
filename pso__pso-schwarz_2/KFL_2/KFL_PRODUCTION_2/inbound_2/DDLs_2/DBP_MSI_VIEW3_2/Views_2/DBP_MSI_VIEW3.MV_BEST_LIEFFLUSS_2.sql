CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_BEST_LIEFFLUSS_2
(
best_beleg_id,
best_beleg_pos_id,
best_entw_typ_id,
bestaetigung_lfd_nr,
lief_beleg_id,
lief_beleg_pos_id,
kj,
kontierung_pos_id,
mandant_id,
menge,
menge_best,
nb_id,
vorgart_best_entw_id,
wup_id,
kj_lief_beleg
)
AS
   SELECT
  v01.best_beleg_id,
   v01.best_beleg_pos_id,
   v01.best_entw_typ_id,
   v01.bestaetigung_lfd_nr,
   v01.folge_beleg_id,
   v01.folge_beleg_pos_id,
   v01.kj,
   v01.kontierung_pos_id,
   v01.mandant_id,
   v01.menge_anteil,
   v01.menge_best,
   v01.nb_id,
   v01.vorgart_best_entw_id,
   v01.wup_id,
   v02.kj
   FROM dbp_view.v_best_belegfluss_2 v01
   LEFT join dbp_view.v_besch_lief_2 v02
   ON v01.folge_beleg_id=v02.lief_beleg_id
   and v01.mandant_id=v02.mandant_id
   and extract(year from v01.dat_buch) between v02.kj-1 and v02.kj+1

   WHERE best_entw_typ_id IN ('L')
   AND v01.kj >= year(current_timestamp) - 2;