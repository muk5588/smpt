package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Component;

@Component
public class ExchangeRateUtils {

    private static HttpURLConnection connection;
    private static final BigDecimal defaultExchangeRate = BigDecimal.valueOf(1300);

    public static BigDecimal[] getExchangeRate() {
        BigDecimal usdExchangeRate = getExchangeRateForCurrency("USD");
        BigDecimal jpyExchangeRate = getExchangeRateForCurrency("JPY(100)");
        BigDecimal cnyExchangeRate = getExchangeRateForCurrency("CNH");
        BigDecimal thbExchangeRate = getExchangeRateForCurrency("THB");
        BigDecimal eurExchangeRate = getExchangeRateForCurrency("EUR");

        return new BigDecimal[]{usdExchangeRate, jpyExchangeRate, cnyExchangeRate, thbExchangeRate, eurExchangeRate};
    }

    public static BigDecimal getExchangeRateForCurrency(String currencyCode) {
        BufferedReader reader;
        String line;
        StringBuffer responseContent = new StringBuffer();
        JSONParser parser = new JSONParser();

        String authKey = "VBOJx0KxId7uHK0nxOU5etyVCX84PjCq";
        String searchDate = new SimpleDateFormat("yyyyMMdd").format(new Date());
        String dataType = "AP01";
        BigDecimal exchangeRate = null;

        try {
            URL url = new URL("https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey=" + authKey + "&searchdate=" + searchDate + "&data=" + dataType);
            connection = (HttpURLConnection) url.openConnection();

            connection.setRequestMethod("GET");
            connection.setConnectTimeout(5000);
            connection.setReadTimeout(5000);

            int status = connection.getResponseCode();

            if (status > 299) {
                reader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
                while ((line = reader.readLine()) != null) {
                    responseContent.append(line);
                }
                reader.close();
            } else {
                reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                while ((line = reader.readLine()) != null) {
                    JSONArray exchangeRateInfoList = (JSONArray) parser.parse(line);

                    for (Object o : exchangeRateInfoList) {
                        JSONObject exchangeRateInfo = (JSONObject) o;
                        if (exchangeRateInfo.get("cur_unit").equals(currencyCode)) {
                            // 환율 정보를 가져오고 BigDecimal 형태로 변환
                            NumberFormat format = NumberFormat.getInstance(Locale.getDefault());
                            double exchangeRateValue = format.parse(exchangeRateInfo.get("deal_bas_r").toString()).doubleValue();
                            exchangeRate = BigDecimal.valueOf(exchangeRateValue);
                            return exchangeRate;
                        }
                    }
                }
                reader.close();
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } catch (java.text.ParseException e) {
            e.printStackTrace();
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }

        // 환율 정보를 가져오지 못한 경우 기본 환율을 반환
        return defaultExchangeRate;
    }

}