CREATE TABLE IF NOT EXISTS kfl_nfmd_core.ts_l_article_cluster (
mandant_id INTEGER,
article_cluster_id BIGNUMERIC(38,0),
article_cluster STRING(255),
article_cluster_bg STRING(255),
article_cluster_cz STRING(255),
article_cluster_en STRING(255),
article_cluster_hr STRING(255),
article_cluster_pl STRING(255),
article_cluster_ro STRING(255),
article_cluster_sk STRING(255),
article_cluster_landessprache STRING(255),
flag_aktiv INTEGER,
flag_deaktiv INTEGER
);