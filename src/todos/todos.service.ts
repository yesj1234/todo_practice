import { Inject, Injectable } from '@nestjs/common';
import { Todo } from './todos.entity';
import { Repository } from 'typeorm';

@Injectable()
export class TodosService {
  constructor(
    @Inject('TODO_REPOSITORY') private todoRepository: Repository<Todo>,
  ) {}
  async getAllTodos(): Promise<Todo[]> {
    return this.todoRepository.find({});
  }
}
