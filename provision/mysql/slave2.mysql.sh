sudo apt update &&
echo "Setup MySQL" &&
sudo apt install --no-install-recommends mysql-server -y &&
sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/default.mysqld.cnf &&
sudo cp /vagrant/config/mysql/slave2.mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf &&
sudo chmod 0444 /etc/mysql/mysql.conf.d/mysqld.cnf &&
sudo service mysql restart &&
sudo mysql -e "
  CREATE USER 'bdt'@'%' IDENTIFIED BY 'bdt';
  GRANT ALL PRIVILEGES ON *.* TO 'bdt'@'%' WITH GRANT OPTION;
  CHANGE MASTER TO MASTER_HOST='192.168.33.20',MASTER_USER='slave',MASTER_PASSWORD='slave',MASTER_LOG_FILE='mysql-bin.000001',MASTER_LOG_POS=154;
  SET GLOBAL SQL_SLAVE_SKIP_COUNTER=1;
  START SLAVE;
" &&
sudo service mysql restart &&
echo "Finish Setup MySQL, try connect with: mysql -h <HOST> -u bdt -pbdt"
