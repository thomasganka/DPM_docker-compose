CREATE DATABASE IF NOT EXISTS `jobrunner`;
CREATE DATABASE IF NOT EXISTS `messaging`;
CREATE DATABASE IF NOT EXISTS `notification`;
CREATE DATABASE IF NOT EXISTS `pipelinestore`;
CREATE DATABASE IF NOT EXISTS `policy`;
CREATE DATABASE IF NOT EXISTS `provisioning`;
CREATE DATABASE IF NOT EXISTS `reporting`;
CREATE DATABASE IF NOT EXISTS `scheduler`;
CREATE DATABASE IF NOT EXISTS `sdp_classification`;
CREATE DATABASE IF NOT EXISTS `security`;
CREATE DATABASE IF NOT EXISTS `sla`;
CREATE DATABASE IF NOT EXISTS `timeseries`;
CREATE DATABASE IF NOT EXISTS `topology`;

CREATE USER 'admin'@'%' identified by 'admin';
grant all privileges on *.* to 'admin'@'%';
CREATE USER 'admin'@'localhost' identified by 'admin';
grant all privileges on *.* to 'admin'@'localhost';

 