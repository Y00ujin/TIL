## GCD

- ##### iOS 면접 질문 준비하기 `211029` with Youjin🙇🏻‍♀️


```
 다수의 스레드에 적절히 작업을 분배시키기 위해 우리가 해야할 일은 task를 queue에 넣는 것이다. 그럼 queue에 넣은 일들을 다수의 스레드로 분배시키는 일은 누가 할까?
 ```


### GCD(Grand Central Dispatch)?
> ##### 프로그래머가 Queue에 작업을 보내면 그에 따른 스레드를 적절히 생성해서 분배해주는 방법입니다.
> ##### GCD에서 사용하는 queue의 이름이 Dispatch Queue(큐로 보내다)이다.
> ##### 즉 Dispatch Queue에 작업을 추가하면 `GCD`는 작업에 맞는 스레드를 자동으로 생성해서 실행하고, 작업이 종료되면 스레드를 제거하게 됩니다.

### GCD 사용법
> ##### queue.async { task } 또는 queue.sync { task } 를 통해 task를 queue로 보내기

#### 비동기 vs 동기
- ##### 비동기
```Swift
// 원래의 작업이 진행되고 있던 메인 스레드에서 global dispatch queue로 task를 보낸 후, 해당 작업이 끝나기를 기다리지 않고 이어서 할 일을 한다 (비동기처리)
DispatchQueue.global().async { 
  // task
  // {} 에 들어가는 task가 작업의 한 단위
  // task는 하나의 작업 뭉탱이기 때문에 그 안의 동작들은 순차적으로 처리가 된다.
}
```

- ##### 동기
```Swift
// 원래의 작업이 진행되고 있던 메인 스레드에서 global dispatch queue로 task를 보낸 후, 다음 라인 실행을 위해 해당 작업이 끝나기를 기다린다 (동기처리)
DispatchQueue.global().sync {
  //task
}
```

#### 직렬 vs 동시
- ##### Serial(직렬) - Serial Queue
###### (보통 메인 스레드에서) 분산 처리 시킨 작업을 “다른 한개의 스레드에서” 처리하는 큐
```
Serial 큐에 담긴 작업들은 오직 하나의 스레드에만 분배됩니다. 모든 작업들이 그 전 작업이 끝나길 기다렸다가 하나씩 실행 되기 때문에 task의 시작과 종료에 대한 순서 예측이 가능합니다.
```

- ##### Concurrent(동시) - Concurrent Queue
###### (보통 메인 스레드에서) 분산 처리 시킨 작업을 “다른 여러개의 스레드에서” 처리하는 큐
```
Concurrent 큐에 담긴 작업들은 여러개의 스레드로 분배됩니다. 선입선출(FIFO)이라는 Queue의 특성상 작업들이 순서대로 분배되어 실행되긴 하겠지만, 그것들이 끝나는 순서는 알 수 없습니다.
```

<br>

> ##### 그냥 빠르면 좋은거예요! 이런 상황에서는 `Concurrent Queue` 를 사용합니다. 하지만 반대로, 순서가 중요한 작업들을 처리해야 한다면 늦게 들어온 것이 먼저 끝나는 상황 등의 방지를 위해 `Serial Queue`를 써야겠죠?

### async vs sync
- ##### 작업을 보내는 시점에서 기다릴지 말지에 대해 다루는 것
### concurrent vs serial
- ##### Queue(대기열)로 보내진 작업들을 여러개의 스레드로 보낼 것인지 한개의 스레드로 보낼 것인지에 대해 다루는 것

<br>

##### `SerialQueue.sync` : 메인 스레드의 작업 흐름이 queue에 넘긴 태스크가 끝날때까지 멈춰있고(sync), 넘겨진 task는 queue에 먼저 담겨있던 작업들과 같은 스레드에 보내지기 때문에 해당 작업들이 모두 끝나야 실행 (Serial Queue)

##### `ConcurrentQueue.sync` : 메인 스레드의 작업 흐름이 queue에 넘긴 태스크가 끝날때까지 멈춰있고(sync), 넘겨진 task는 queue에 먼저 담겨있던 작업들과 다른 스레드에 보내질 수 있기 때문에 해당 작업들이 모두 끝나지 않아도 실행 (Concurrent Queue)

##### `SerialQueue.async` : 메인 스레드의 작업 흐름이 태스크를 queue에 넘기자마자 반환되고 (async), 넘겨진 task는 queue에 먼저 담겨있던 작업들과 같은 스레드에 보내지기 때문에 해당 작업들이 모두 끝나야 실행 (Serial Queue)

##### `ConcurrentQueue.async` : 메인 스레드의 작업 흐름이 태스크를 queue에 넘기자마자 반환되고 (async), 넘겨진 task는 queue에 먼저 담겨있던 작업들과 다른 스레드에 보내질 수 있기 때문에 해당 작업들이 모두 끝나지 않아도 실행 (Concurrent Queue)

<br>

##### 참고자료
- ###### https://jinshine.github.io/2018/07/09/iOS/GCD(Grand%20Central%20Dispatch)/
- ###### https://sujinnaljin.medium.com/ios-%EC%B0%A8%EA%B7%BC%EC%B0%A8%EA%B7%BC-%EC%8B%9C%EC%9E%91%ED%95%98%EB%8A%94-gcd-2-a65e1c28665d
- ###### https://jinshine.github.io/2018/07/09/iOS/GCD(Grand%20Central%20Dispatch)/
- ###### https://sujinnaljin.medium.com/ios-%EC%B0%A8%EA%B7%BC%EC%B0%A8%EA%B7%BC-%EC%8B%9C%EC%9E%91%ED%95%98%EB%8A%94-gcd-grand-dispatch-queue-1-397db16d0305
- ###### https://sujinnaljin.medium.com/ios-%EC%B0%A8%EA%B7%BC%EC%B0%A8%EA%B7%BC-%EC%8B%9C%EC%9E%91%ED%95%98%EB%8A%94-gcd-3-1e706a74086b