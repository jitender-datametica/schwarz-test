create if not exists table LDL_PRODUCTION.p_lew_core.t_item_familygroup_1 (
	client_id number(38,0) not null comment 'dwh-mandant_1; fk auf client;
            cbx: static 7 (stiftung);
            esb: static 7 (stiftung);',
	item_fam_grp_sid number(38,0) not null comment 'surrogate key item_1 familygroup;
            cbx: item.ldlarticlegroup.custtext1;
            esb: cbxitem.itemfamilygroup.code;
            ',
	src_node varchar(20) comment 'knotennummer aus sap-hierarchie;
            sap-retail: wrf_matgrp_struc.node;
            sap-bw: z_ds_wrf_matgrp_struc.node;
            cbx: null;
            esb: null;',
	src_familygrp_cd varchar(20) comment 'wawi code;
            cbx: item.ldlarticlegroup.custtext1;
            esb: cbxitem.itemfamilygroup.code;',
	src_familygrp_id number(38,0) comment 'wawi id;
            cbx: null;
            esb: null;',
	item_fam_grp_name varchar(100) collate 'en-ci' comment 'familygroupname in stiftungssprache;
            sap-retail: wrf_matgrp_strct.ltext;
            sap-bw: z_ds_wrf_matgrp_strct.ltext;
            cbx: item.ldlarticlegroup.custtext3;
            esb: cbxitem.itemfamilygroup.name;',
	dwh_load_id number(38,0) not null comment 'identifier of the last run which inserted or updated the record. -1 means manually inserted.',
	dwh_created timestamp_ntz(9) not null comment 'creation timestamp of the record in the dwh.',
	dwh_updated timestamp_ntz(9) not null comment 'timestamp of the last update of the record in the dwh.',
	constraint pk_t_item_familygroup primary key (item_fam_grp_sid)
)comment='$revision: 0000 $. famg; 2. ebene der artikelhierarchie. direkt oberhalb des artikels;'
;