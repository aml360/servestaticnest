import {
  MiddlewareConsumer,
  Module,
  NestModule,
  RequestMethod,
} from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { join } from 'path';
import { ServeStaticModule } from '@nestjs/serve-static';
import { CompressionMiddleware } from '@aml360/nestjs-compression';

@Module({
  imports: [
    ServeStaticModule.forRoot({
      rootPath: join('/app', '/ngDist'),
      exclude: ['/nest*'],
    }),
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    //Modulo que comprime las request con gzip
    CompressionMiddleware.configure({ level: 8 });
    consumer
      .apply(CompressionMiddleware)
      .forRoutes({ path: '**', method: RequestMethod.ALL });
  }
}
