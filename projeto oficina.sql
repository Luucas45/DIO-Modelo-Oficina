create database oficina;
use oficina;

create table clientes(
		idcliente int not null primary key,
        nome varchar(45),
        carro_modelo varchar(45) not null,
        ultima_visita date,
        endereço varchar(45));
        
create table estoque(
		idiventario int not null primary key,
        pecas varchar(45),
        valor_pecas float);
        
create table funcionario(
		idfuncionario int not null primary key,
        nome varchar(45),
        endereço varchar(45),
        data_nascimento date,
        data_admissão date,
        especialidade varchar(45));
        
create table ordem_serviço(
		idordem int not null primary key,
        data_emissão date,
        data_conclusão date,
        status_carro varchar(45),
        idiventario int not null,
        idfuncionario int not null,
        idcliente int not null,
        foreign key (idiventario) references estoque(idiventario),
        foreign key (idfuncionario) references funcionario(idfuncionario),
        foreign key (idcliente) references clientes(idcliente));
        
insert into clientes(idcliente,nome,carro_modelo,ultima_visita,endereço)
values (1,'claudio lima','fusca','2020-01-20','avenida carlos pessoa'),
		(2,'antonio carlos','corsa','2020-02-21','rua miguel carlos'),
        (3,'julio cesar','fiat uno','2020-03-05','rua angelo silva'),
        (4,'maria luz','fusca','2020-08-03','avenida ruan manoel borba'),
        (5,'katia barros','fiat uno','2020-09-14','avenida brasil');

insert into estoque values  (1,'mola',30),
							(2,'ignição',60),
                            (3,'volante',100),
                            (4,'volante',100),
                            (5,'vidro',200);

insert into funcionario values(1,'leonardo neto','praça do carmo','1995-05-06','2019-01-02'),
								(2,'mauro lucio','rio verde','1996-05-04','2018-05-05'),
                                (3,'julio lima','casa caiada','1993-08-03','2018-06-01');


insert into ordem_serviço values (1,'2021-02-01','2021-02-08','novo',3,2,2),
								(2,'2021-03-05','2021-03-15','usado',1,1,5),
                                (3,'2021-09-06','2021-09-14','novo',2,3,4),
                                (4,'2021-05-05','2021-05-10','usado',1,3,1);
                                
select * from ordem_serviço;
select * from clientes;
select * from funcionario;
select * from estoque;

-- qual a peça necessária para o serviço no carro da Sra. katia barros?
select nome, pecas
from ordem_serviço
inner join clientes using (idcliente)
inner join estoque  using (idiventario)
where nome = "katia barros";

-- qual modelo de carro foi mais levado à oficina de fevereiro/2020 até outubro/2020?
select carro_modelo, count(*) as total
from clientes
where ultima_visita between '2020-02-01' and '2020-10-31'
group by carro_modelo
order by total desc;


