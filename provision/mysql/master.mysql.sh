sudo apt update &&
echo "Setup MySQL" &&
sudo apt install --no-install-recommends mysql-server -y &&
sudo mv /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/mysql.conf.d/default.mysqld.cnf &&
sudo cp /vagrant/config/mysql/master.mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf &&
sudo chmod 0444 /etc/mysql/mysql.conf.d/mysqld.cnf &&
sudo mysql -e "
  CREATE USER 'bdt'@'%' IDENTIFIED BY 'bdt';
  GRANT ALL PRIVILEGES ON *.* TO 'bdt'@'%' WITH GRANT OPTION;
  GRANT REPLICATION SLAVE ON *.* to 'slave'@'%' IDENTIFIED BY 'slave';
" &&
sudo service mysql restart &&
echo "Finish Setup MySQL, try connect with: mysql -h <HOST> -u bdt -pbdt"
