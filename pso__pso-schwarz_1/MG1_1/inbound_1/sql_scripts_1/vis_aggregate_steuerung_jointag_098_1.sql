CREATE  TABLE DBP_ETL.dat_vj_vergl_abschrift_1
(
	mandant_id BYTEINT
	,wup_id INTEGER NOT NULL
	,nb_id SMALLINT
	,join_dat DATE  NOT NULL
	,dat DATE  NOT NULL
	,gj SMALLINT NOT NULL
	,kjwo INTEGER NOT NULL
	,kjmo INTEGER NOT NULL
	,mo_kj BYTEINT NOT NULL
	,akt_gj SMALLINT NOT NULL
	,akt_mo SMALLINT NOT NULL
	,akt_wo SMALLINT NOT NULL
	,akt_tag SMALLINT NOT NULL
	,wtag_id BYTEINT NOT NULL
	,akt_gj_fg byteint not null
	,vj_1_fg byteint not null
	
	,vj_2_fg byteint not null
	,vj_wt_1_fg byteint not null
	,vj_wt_2_fg byteint not null
)
;
