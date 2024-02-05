create database CINE_ARTE_ATREZZO;
use CINE_ARTE_ATREZZO;

create table cliente(
                        id_cliente int primary key auto_increment,
                        nombre varchar(50),
                        apellido varchar(50),
                        telefono int,
                        email varchar(50),
                        cuenta_bancaria int,
                        direccion varchar(50)
);

drop table cliente;

create table trasportista(
                             id_trasportista int primary key auto_increment,
                             nombre varchar(50),
                             apellido varchar(50),
                             telefono varchar(50),
                             email varchar(50),
                             cuenta_bancaria varchar(50),
                             direccion varchar(50)
);

drop table trasportista;

create table pedido(
                       id_pedido int primary key auto_increment,
                       fecha_pedido date,
                       fecha_entrega date,
                       fecha_devolucion date,
                       estado varchar(50),
                       id_cliente int,
                       foreign key (id_cliente) references cliente(id_cliente)
);

drop table pedido;

create table producto(
                         id_producto int primary key auto_increment,
                         nombre varchar(50),
                         descripcion varchar(70),
                         precio float,
                         stock int
);

drop table producto;

create table pedido_transportista(
                                     id_pedido_transportista int primary key auto_increment,
                                     id_pedido int,
                                     id_trasportista int,
                                     foreign key (id_pedido) references pedido(id_pedido),
                                     foreign key (id_trasportista) references trasportista(id_trasportista)
);

drop table pedido_transportista;

create table orden_entrega(
                              id_orden_entrega int primary key auto_increment,
                              fecha_entrega date
);

drop table orden_entrega;

create table detalle_pedido(
                               id_detalle_pedido int primary key auto_increment,
                               id_pedido int,
                               id_producto int,
                               cantidad int,
                               foreign key (id_pedido) references pedido(id_pedido),
                               foreign key (id_producto) references producto(id_producto)
);

drop table detalle_pedido;

create table factura(
                        id_factura int primary key auto_increment,
                        monto float,
                        fecha_factura date,
                        id_pedido int,
                        foreign key (id_pedido) references pedido(id_pedido)
);

drop table factura;

INSERT INTO cliente (nombre, apellido, telefono, email, cuenta_bancaria, direccion) VALUES
    ('Juan', 'Gomez', 123456789, 'juan@gmail.com', 987654321, 'Calle 123'),
    ('Maria', 'Lopez', 987654321, 'maria@gmail.com', 123456789, 'Avenida 456'),
    ('Pedro', 'Ramirez', 555123456, 'pedro@gmail.com', 654321987, 'Calle 789'),
    ('Laura', 'Garcia', 555987654, 'laura@gmail.com', 789456123, 'Avenida 101'),
    ('Carlos', 'Fernandez', 555555555, 'carlos@gmail.com', 111222333, 'Calle 567');

INSERT INTO trasportista (nombre, apellido, telefono, email, cuenta_bancaria, direccion) VALUES
    ('Ana', 'Martinez', '555-1234', 'ana@gmail.com', '123-456-789', 'Calle 789'),
    ('Eduardo', 'Rodriguez', '555-5678', 'eduardo@gmail.com', '987-654-321', 'Avenida 101'),
    ('Luisa', 'Lopez', '555-9876', 'luisa@gmail.com', '456-789-123', 'Calle 111'),
    ('Roberto', 'Gutierrez', '555-4321', 'roberto@gmail.com', '789-123-456', 'Avenida 222'),
    ('Marina', 'Perez', '555-8765', 'marina@gmail.com', '321-654-987', 'Calle 333');

INSERT INTO pedido (fecha_pedido, fecha_entrega, fecha_devolucion, estado, id_cliente) VALUES
    ('2024-02-01', '2024-02-10', '2024-02-15', 'En proceso', 1),
    ('2024-02-02', '2024-02-12', '2024-02-18', 'Entregado', 2),
    ('2024-02-03', '2024-02-15', '2024-02-20', 'En proceso', 3),
    ('2024-02-04', '2024-02-20', '2024-02-25', 'En camino', 4),
    ('2024-02-05', '2024-02-25', '2024-03-02', 'Entregado', 5);

INSERT INTO producto (nombre, descripcion, precio, stock) VALUES
    ('Producto1', 'Descripción1', 20.99, 100),
    ('Producto2', 'Descripción2', 15.49, 75),
    ('Producto3', 'Descripción3', 30.75, 50),
    ('Producto4', 'Descripción4', 10.25, 120),
    ('Producto5', 'Descripción5', 25.50, 80);

INSERT INTO pedido_transportista (id_pedido, id_trasportista) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5);

INSERT INTO orden_entrega (fecha_entrega) VALUES
    ('2024-02-10'),
    ('2024-02-15'),
    ('2024-02-18'),
    ('2024-02-20'),
    ('2024-02-25');

INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad) VALUES
    (1, 1, 10),
    (1, 2, 5),
    (2, 1, 8),
    (2, 3, 12),
    (3, 4, 6);

INSERT INTO factura (monto, fecha_factura, id_pedido) VALUES
    (150.45, '2024-02-15', 1),
    (120.75, '2024-02-18', 2),
    (200.20, '2024-02-20', 3),
    (80.50, '2024-02-25', 4),
    (300.00, '2024-03-02', 5);

select *
from cliente;

select *
from trasportista;

select *
from pedido;

select *
from producto;

select p.*, dp.id_producto, dp.cantidad
from pedido p
inner join detalle_pedido dp on p.id_pedido = dp.id_pedido;

select *
from pedido
where estado = 'Entregado';

select *
from pedido
where estado = 'En camino';

select *
from producto
where stock > 0;

select *
from pedido
where id_cliente = :id_cliente;

select c.nombre, sum(f.monto) as total_gastado
from cliente c
inner join pedido p on c.id_cliente = p.id_cliente
inner join factura f on p.id_pedido = f.id_pedido
group by c.nombre;

select p.id_pedido, p.fecha_entrega, t.nombre as trasportista
from pedido p
inner join pedido_transportista pt on p.id_pedido = pt.id_pedido
inner join trasportista t on pt.id_trasportista = t.id_trasportista
where p.estado = 'Entregado';

select sum(dp.cantidad) as cantidad_total_vedida
from detalle_pedido dp
group by dp.id_producto;

select SUM(dp.cantidad) as cantidad_total_vendida
from detalle_pedido dp
inner join pedido p on dp.id_producto = p.id_pedido
where p.fecha_pedido between :fecha_inicio and :fecha_fin;

select sum(f.monto) as monto_total_facturado
from factura f
inner join pedido p on f.id_pedido = p.id_pedido
where p.fecha_pedido between :fecha_inicio and :fecha_fin;

select c.nombre, count(p.id_pedido) as num_pedidos
from cliente c
left join pedido p on c.id_cliente = p.id_cliente
group by c.nombre;

select p.nombre as producto_mas_vendido, sum(dp.cantidad) as total_vendido
from producto p
inner join detalle_pedido dp on p.id_producto = dp.id_producto
group by p.nombre
order by sum(dp.cantidad) desc
limit 1;

select t.nombre as trasportista, count(p.id_pedido) as num_pedidos_entregados
from trasportista t
inner join pedido_transportista pt on t.id_trasportista = pt.id_trasportista
inner join pedido p on pt.id_pedido = p.id_pedido
where p.estado = 'Entregado'
group by t.nombre
order by count(p.id_pedido) desc
limit 1;

select p.id_pedido, min(p.fecha_entrega) as fecha_entrega_proxima
from pedido p
where p.estado = 'En proceso'
group by p.id_pedido;

select avg(precio) as precio_promedio
from producto;

select distinct c.nombre, c.apellido
from cliente c
inner join pedido p on c.id_cliente = p.id_cliente
where p.fecha_pedido >= date_sub(now(), interval 1 month );