package com.config;

import java.io.*;
import java.util.*;

/**
 * Naver OAuth Configuration Loader
 * Loads Naver OAuth configuration from src/main/resources/naver.properties
 */
public class NaverConfig {
    private static Properties properties;
    
    static {
        properties = new Properties();
        try {
            InputStream input = NaverConfig.class.getClassLoader()
                    .getResourceAsStream("naver.properties");
            
            if (input == null) {
                System.err.println("naver.properties 파일을 찾을 수 없습니다.");
                throw new RuntimeException("naver.properties 파일이 필요합니다. naver.properties.example을 참고하세요.");
            }
            
            properties.load(input);
            input.close();
            System.out.println("Naver OAuth 설정 로드 완료");
        } catch (IOException e) {
            System.err.println("naver.properties 로드 중 오류 발생: " + e.getMessage());
            throw new RuntimeException(e);
        }
    }
    
    /**
     * 설정값 조회
     * @param key 설정 키
     * @return 설정값
     */
    public static String get(String key) {
        return properties.getProperty(key);
    }
    
    /**
     * Naver Client ID
     */
    public static String getClientId() {
        return get("naver.client.id");
    }
    
    /**
     * Naver Client Secret
     */
    public static String getClientSecret() {
        return get("naver.client.secret");
    }
    
    /**
     * Naver Callback URL
     */
    public static String getCallbackUrl() {
        return get("naver.callback.url");
    }
}
