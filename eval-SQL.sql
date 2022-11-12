# Creacion de la base + creacion de tablas

create schema if not exists minimarket;
create table `minimarket`.`cliente`(
`cliente_id` int not null auto_increment,
`nombre` varchar(40) not null,
`rut` varchar(15),
`correo` varchar(30),
`telefono` varchar(12),
primary key (`cliente_id`));

create table `minimarket`.`tipoProducto`(
`tipo_id` int not null auto_increment,
`categoria` varchar(30) not null,
primary key (`tipo_id`));

create table `minimarket`.`proveedor`(
`proveedor_id` int not null auto_increment,
`nombre` varchar(30) not null,
`direccion` varchar(30),
`telefono` varchar(12),
primary key (`proveedor_id`));

create table `minimarket`.`venta`(
`venta_id` int not null auto_increment,
`fecha` date not null,
primary key(`venta_id`));

create table `minimarket`.`detalleVenta`(
`detalle_id` int not null auto_increment,
`precio_total` date not null,
`cantidad_productos` int not null,
primary key(`detalle_id`));

create table `minimarket`.`producto`(
`producto_id` int not null auto_increment,
`nombre` varchar(20) not null,
`marca` varchar(20),
`precio_venta` int not null,
`precio_compra` int not null,
`stock` int,
primary key (`producto_id`));

# Modificacion de tablas para crear llaves foraneas y por consecuencia, relaciones entre tablas

alter table minimarket.venta add cliente_id int not null;
alter table minimarket.venta add constraint ventaCliente foreign key (cliente_id) references minimarket.cliente(cliente_id);

alter table minimarket.detalleVenta add venta_id int not null;
alter table minimarket.detalleVenta add constraint detalleVenta_venta foreign key (venta_id) references minimarket.venta(venta_id);

alter table minimarket.detalleVenta add producto_id int not null;
alter table minimarket.detalleVenta add constraint detVentaProducto foreign key (producto_id) references minimarket.producto(producto_id);

alter table minimarket.producto add proveedor_id int not null;
alter table minimarket.producto add constraint productoProveedor foreign key (proveedor_id) references minimarket.proveedor(proveedor_id);

alter table minimarket.producto add tipo_id int not null;
alter table minimarket.producto add constraint productoTipoProducto foreign key (tipo_id) references minimarket.tipoProducto(tipo_id);

# Insercion de datos para poblar la base (tablas producto, proveedor y tipoProducto)

insert into minimarket.proveedor (nombre) values ('La Colchagüina');

insert into minimarket.tipoProducto (categoria) values ('Aseo');
insert into minimarket.tipoProducto (categoria) values ('Lacteos');
insert into minimarket.tipoProducto (categoria) values ('Cotillon');
insert into minimarket.tipoProducto (categoria) values ('Alcohol');

insert into minimarket.producto (nombre, marca, precio_venta, precio_compra, proveedor_id, tipo_id)
values ('Jabon', 'Dove', 2000, 1200, 1, 1);
insert into minimarket.producto (nombre, marca, precio_venta, precio_compra, proveedor_id, tipo_id)
values ('Queso', 'Colun', 5000, 3500, 1, 2);
insert into minimarket.producto (nombre, precio_venta, precio_compra, proveedor_id, tipo_id)
values ('Globos', 100, 50, 1, 3);
insert into minimarket.producto (nombre, precio_venta, precio_compra, proveedor_id, tipo_id, stock)
values ('Pisco', 7000, 4500, 1, 4, 20);
insert into minimarket.producto (nombre, precio_venta, precio_compra, proveedor_id, tipo_id, stock)
values ('Cerveza', 800, 400, 1, 4, 60);

update minimarket.producto
set marca = 'Mal Paso'
where nombre = 'Pisco';

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

# Algunas consultas

select * from minimarket.tipoProducto;
select * from minimarket.producto;

select nombre, categoria
from minimarket.producto p, minimarket.tipoProducto tp
where tp.tipo_id = p.tipo_id;

select *
from minimarket.producto p, minimarket.tipoProducto tp
where tp.tipo_id = p.tipo_id;

select *
from minimarket.producto p, minimarket.tipoProducto tp
where tp.tipo_id = p.tipo_id;

select nombre, categoria
from minimarket.producto p left join minimarket.tipoProducto tp
on p.tipo_id = tp.tipo_id and tp.categoria = 'alcohol';