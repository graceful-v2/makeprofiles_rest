package com.make_profile.configuration;

import org.springframework.amqp.core.QueueBuilder;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.amqp.core.Queue;



public class RabbitMQConfig {

//    public static final String REQUEST_QUEUE = "pdf_request_queue";
//    public static final String RESPONSE_QUEUE = "pdf_response_queues";
//
//
//
//
//
//    @Bean
//    public Queue pdfRequestQueue() {
//
//
//        return QueueBuilder
//                .durable(REQUEST_QUEUE)
//                .withArgument("x-dead-letter-exchange", "")
//                .build();
//    }
//
//
//    @Bean
//    public Queue pdfjobResponseQueue() {
//        return QueueBuilder.durable(RESPONSE_QUEUE).build();
//    }
}
