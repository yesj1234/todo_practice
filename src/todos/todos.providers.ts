import { DataSource } from 'typeorm';
import { Todo } from './todos.entity';
export const todoProvider = [
  {
    provide: 'TODO_REPOSITORY',
    useFactory: (dataSource: DataSource) => dataSource.getRepository(Todo),
    inject: ['DATA_SOURCE'],
  },
];
