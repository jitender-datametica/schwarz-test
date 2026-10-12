/* AW check 2021-05-10*/
CREATE TABLE DBP_ETL.dat_vj_vergleich_tmp_1  (
	join_dat DATE NOT NULL   -- a) Diese Datum wird mit der DBP_DATA.artbew_tag_wg_wup_sum gejoint
	,dat DATE NOT NULL       -- b) Auf dieses Datum werden die Daten aggregiert
	,gj SMALLINT not null
	,kjwo INTEGER NOT NULL
	,kjmo INTEGER NOT NULL
	,mo_kj BYTEINT NOT NULL
	,akt_gj SMALLINT NOT NULL
	,akt_mo SMALLINT NOT NULL
	,akt_wo SMALLINT NOT NULL
	,akt_tag SMALLINT NOT NULL
	,wtag_id BYTEINT NOT NULL
	,akt_gj_fg byteint not NULL                  -- c) 1 wenn join_dat=dat, dann ist dies der aktuelle Tageswert
	
	,vj_1_fg byteint not null                    -- d) 1 wenn join_dat=dat-1 Jahr (z.B. dat=1.3.2007 --> join_dat=1.3.2006)
	--   wird für die Kummulierung der Vorjahre gebraucht
	,vj_2_fg byteint not null                    -- e) siehe d) nur für das Vorvorjahr
	,vj_wt_1_fg byteint not null     -- f) 1 wenn join_dat=dat-364 (Wochentagsvergleich (Mi=Mi Vorjahr)
	,vj_wt_2_fg byteint not null     -- g) 1 wenn join_dat=dat-728 (Wochentagsvergleich (Mi=Mi Vorjahr)
)
;

DROP TABLE IF EXISTS DBP_ETL.dat_vj_vergleich_1;
